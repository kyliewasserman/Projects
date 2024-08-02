#pragma once
#include <SFML/Graphics.hpp>

class Bat
{
private:
	sf::Vector2f m_Position;
	sf::Sprite m_Shape;
	sf::Texture m_Texture;

	float m_Speed = 1000.0f;

	bool m_MovingDown = false;
	bool m_MovingUp = false;

	bool m_MovingLeftArrow = false;
	bool m_MovingRightArrow = false;
	bool m_MovingLeftKey = false;
	bool m_MovingRightKey = false;


public:
	Bat(float startX, float startY);

	sf::FloatRect getPosition();

	sf::Sprite getShape();

	void moveUp();

	void moveDown();

	void stopUp();

	void stopDown();

	void moveLeftArrow();

	void moveRightArrow();

	void moveLeftKey();

	void moveRightKey();

	void stopLeftArrow();

	void stopRightArrow();

	void stopLeftKey();

	void stopRightKey();

	void update(sf::Time dt);

};
