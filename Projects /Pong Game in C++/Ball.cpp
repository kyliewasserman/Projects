#include "Ball.h"

// This the constructor function
Ball::Ball(float startX, float startY)
{
	m_Position.x = startX;
	m_Position.y = startY;

	// load the texture, now using a sprite object
	m_Texture.loadFromFile("graphics/bubble1.png");
	m_Sprite.setTexture(m_Texture);
	m_Sprite.setPosition(m_Position);

	m_Shape.setSize(sf::Vector2f(10, 10));
	m_Shape.setPosition(m_Position);
}

sf::FloatRect Ball::getPosition()
{
	return m_Sprite.getGlobalBounds();
}

sf::Sprite Ball::getSprite()
{
	return m_Sprite;
}

sf::RectangleShape Ball::getShape()
{
	return m_Shape;
}

float Ball::getYVelocity()
{
	return m_DirectionY;
}

void Ball::reboundSides()
{
	m_DirectionY = -m_DirectionY;

	// if the ball hits the top or bottom, make it this texture
	m_Texture.loadFromFile("graphics/bubble3.png");
	m_Sprite.setTexture(m_Texture);
}

void Ball::reboundBatOrLeft()
{
	m_DirectionX = -m_DirectionX;
	
	// if the ball hits the bat, make it this texture
	m_Texture.loadFromFile("graphics/bubble1.png");
	m_Sprite.setTexture(m_Texture);

}

void Ball::reboundRight()
{
	m_Position.y = 0;
	m_Position.x = 500;
	m_DirectionX = -m_DirectionX;
}

void Ball::update(sf::Time dt)
{
	// Update the ball position variables
	m_Position.y += m_DirectionY * m_Speed * dt.asSeconds();
	m_Position.x += m_DirectionX * m_Speed * dt.asSeconds();

	// Move the ball and the bat
	m_Sprite.setPosition(m_Position);
}