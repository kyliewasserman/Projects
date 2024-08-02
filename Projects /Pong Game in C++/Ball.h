#pragma once
#include <SFML/Graphics.hpp>

class Ball
{
private:
	sf::Vector2f m_Position;
	sf::Sprite m_Sprite;
	sf::Texture m_Texture;
	sf::RectangleShape m_Shape;

	float m_Speed = 1000.0f;
	float m_DirectionX = .2f;
	float m_DirectionY = .2f;

public:
	Ball(float startX, float startY);

	sf::FloatRect getPosition();

	sf::Sprite getSprite();

	sf::RectangleShape getShape();

	float getYVelocity();

	void reboundSides();

	void reboundBatOrLeft();

	void reboundRight();

	void update(sf::Time dt);

};