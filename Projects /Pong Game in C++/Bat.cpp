#include "Bat.h"

// This the constructor and it is called when we create an object
Bat::Bat(float startX, float startY)
{
	m_Position.x = startX;
	m_Position.y = startY;
	
	// now using a sprite object
	m_Texture.loadFromFile("graphics/rainbow.jpg");
	m_Shape.setTexture(m_Texture);
	m_Shape.setPosition(m_Position);

}

sf::FloatRect Bat::getPosition()
{
	return m_Shape.getGlobalBounds();
}

sf::Sprite Bat::getShape()
{
	return m_Shape;
}

void Bat::moveUp()
{
	m_MovingUp = true;

}

void Bat::moveDown()
{
	m_MovingDown = true;
}

void Bat::stopUp()
{
	m_MovingUp = false;

}

void Bat::stopDown()
{
	m_MovingDown = false;
}

void Bat::moveLeftArrow()
{
	m_MovingLeftArrow = true;
}

void Bat::moveRightArrow()
{
	m_MovingRightArrow = true;
}

void Bat::moveLeftKey()
{
	m_MovingLeftKey = true;
}

void Bat::moveRightKey()
{
	m_MovingRightKey = true;
}

void Bat::stopLeftArrow()
{
	m_MovingLeftArrow = false;
}

void Bat::stopRightArrow()
{
	m_MovingRightArrow = false;
}

void Bat::stopLeftKey()
{
	m_MovingLeftKey = false;
}

void Bat::stopRightKey()
{
	m_MovingRightKey = false;
}

void Bat::update(sf::Time dt)
{
	if (m_MovingUp)
	{
		m_Position.y -= m_Speed * dt.asSeconds();

		// Check if the bat has gone off the left side of the screen
		if (m_Position.y < 0)
		{
			// Wrap it to the right side of the screen
			m_Position.y = 1080;
		}
	}

	if (m_MovingDown)
	{
		m_Position.y += m_Speed * dt.asSeconds();

		// Check if the bat has gone off the right side of the screen
		if (m_Position.y > 1080)
		{
			// Wrap it to the left side of the screen
			m_Position.y = 0;
		}
	}

	if (m_MovingLeftArrow)
	{
		m_Position.x -= m_Speed * dt.asSeconds();

		if (m_Position.x < 1516)
		{
			m_Position.x = 1516;
		}
	}

	if (m_MovingRightArrow)
	{
		m_Position.x += m_Speed * dt.asSeconds();

		if (m_Position.x > 1880)
		{
			m_Position.x = 1880;
		}
	}

	if (m_MovingLeftKey)
	{
		m_Position.x -= m_Speed * dt.asSeconds();

		if (m_Position.x < 20)
		{
			m_Position.x = 20;
		}
	}

	if (m_MovingRightKey)
	{
		m_Position.x += m_Speed * dt.asSeconds();

		if (m_Position.x > 404)
		{
			m_Position.x = 404;
		}
	}

	m_Shape.setPosition(m_Position);
}
