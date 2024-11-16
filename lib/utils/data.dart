import 'package:travel_plan/models/plan.dart';
import 'package:travel_plan/models/plan_item.dart';

String emptyImage = 'https://www.generationsforpeace.org/wp-content/uploads/2018/03/empty.jpg';

List<PlanItem> planItems = [
  PlanItem(
    id: '678565fe-ec80-4493-9b28-d3fbde6d1127',
    stt: 1,
    timeStart: '09:30',
    timeClose: '11:00',
    locationId: '93e22b07-98cb-4826-a998-ff226e7067c1',
    locationName: 'Tượng Chúa Kitô Vua',
    numberDay: 1, 
    locationNote: '',
  ),
  PlanItem(
    id: '428590c7-3fbd-45db-9c5d-fe27e48351d0',
    stt: 2,
    timeStart: '11:00',
    timeClose: '12:30',
    locationId: '4ffb0977-f5ad-4a41-b56a-3a0cef0cdaf1',
    locationName: 'Hải Đăng Vũng Tàu',
    numberDay: 1,
    locationNote: '',
  ),
  // Add more PlanItem objects as needed
];

Plan plan = Plan(
  id: '6ff624dd-57a2-42f3-9a8d-480c1569f15b',
  textUserInput:
      'Tôi muốn đi chơi vũng tàu 2 ngày 1 dêm chi phí không là vấn đề và khám phá được nhiều nơi',
  title: 'Du ngoạn Vũng Tàu 2 ngày 1 đêm',
  destination: 'Bà Rịa - Vũng Tàu',
  tourDuration: '2 ngày 1 đêm',
  description:
      '**Giới thiệu điểm đến**\nVũng Tàu là một thành phố biển xinh đẹp...',
  vehicle: 'Ô tô',
  totalCostAvg: 2000000,
  vehicleCost: 500000,
  roomCost: 500000,
  foodCost: 500000,
  ticketCost: 200000,
  otherCost: 100000,
  username: 'trankimhoang1710@gmail.com',
  planItems: planItems,
);
