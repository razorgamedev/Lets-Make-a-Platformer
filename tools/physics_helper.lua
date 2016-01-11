function rect_collision(rect_1,rect_2)

	if rect_1.pos.x + rect_1.size.x > rect_2.pos.x and
	   rect_1.pos.x < rect_2.pos.x+rect_2.size.x   and
	   rect_1.pos.y + rect_1.size.y > rect_2.pos.y and
	   rect_1.pos.y < rect_2.pos.y+rect_2.size.y   then

	   	
	   	return true,rect_2
	end

	return false,nil
end