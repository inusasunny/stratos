import { Component, OnInit, Input } from '@angular/core';
import { APIResource } from '../../../store/types/api.types';
import { IService, IServiceExtra } from '../../../core/cf-api-svc.types';

@Component({
  selector: 'app-service-icon',
  templateUrl: './service-icon.component.html',
  styleUrls: ['./service-icon.component.scss']
})
export class ServiceIconComponent implements OnInit {

  image = '';

  extraInfo: IServiceExtra;
  @Input() service: APIResource<IService>;

  @Input() addMenuPadding = false;
  constructor() { }

  ngOnInit() {
    if (this.service) {
      this.extraInfo = this.service.entity.extra ? JSON.parse(this.service.entity.extra) : null;
      if (this.extraInfo && this.extraInfo.imageUrl) {
        this.image = this.extraInfo.imageUrl;
      }
    }
  }

  imageLoadError() {
    this.image = '';
  }
}
