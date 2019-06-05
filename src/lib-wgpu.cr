@[Link(ldflags: "-L#{__DIR__}/../vendor/wgpu/target/debug -lwgpu_native")]
lib LibWGPU
  WGPUMAX_BIND_GROUPS                =     4
  WGPUMAX_COLOR_TARGETS              =     4
  WGPUMAX_VERTEX_BUFFERS             =     8
  WGPUShaderStage_NONE               =     0
  WGPUShaderStage_VERTEX             =     1
  WGPUShaderStage_FRAGMENT           =     2
  WGPUShaderStage_COMPUTE            =     4
  WGPUBufferUsage_MAP_READ           =     1
  WGPUBufferUsage_MAP_WRITE          =     2
  WGPUBufferUsage_TRANSFER_SRC       =     4
  WGPUBufferUsage_TRANSFER_DST       =     8
  WGPUBufferUsage_INDEX              =    16
  WGPUBufferUsage_VERTEX             =    32
  WGPUBufferUsage_UNIFORM            =    64
  WGPUBufferUsage_STORAGE            =   128
  WGPUBufferUsage_NONE               =     0
  WGPUColorWrite_RED                 =     1
  WGPUColorWrite_GREEN               =     2
  WGPUColorWrite_BLUE                =     4
  WGPUColorWrite_ALPHA               =     8
  WGPUColorWrite_COLOR               =     7
  WGPUColorWrite_ALL                 =    15
  WGPUTextureUsage_TRANSFER_SRC      =     1
  WGPUTextureUsage_TRANSFER_DST      =     2
  WGPUTextureUsage_SAMPLED           =     4
  WGPUTextureUsage_STORAGE           =     8
  WGPUTextureUsage_OUTPUT_ATTACHMENT =    16
  WGPUTextureUsage_NONE              =     0
  WGPUTextureUsage_WRITE_ALL         =    26
  WGPUTextureUsage_UNINITIALIZED     = 65535
  WGPUTextureAspectFlags_COLOR       =     1
  WGPUTextureAspectFlags_DEPTH       =     2
  WGPUTextureAspectFlags_STENCIL     =     4
  enum WGPUAddressMode : Int16
    ClampToEdge  = 0
    Repeat       = 1
    MirrorRepeat = 2
  end
  enum WGPUBindingType : Int16
    UniformBuffer        =  0
    Sampler              =  1
    SampledTexture       =  2
    StorageBuffer        =  3
    UniformBufferDynamic =  4
    StorageBufferDynamic =  5
    StorageTexture       = 10
  end
  enum WGPUBlendFactor : Int16
    Zero               =  0
    One                =  1
    SrcColor           =  2
    OneMinusSrcColor   =  3
    SrcAlpha           =  4
    OneMinusSrcAlpha   =  5
    DstColor           =  6
    OneMinusDstColor   =  7
    DstAlpha           =  8
    OneMinusDstAlpha   =  9
    SrcAlphaSaturated  = 10
    BlendColor         = 11
    OneMinusBlendColor = 12
  end
  enum WGPUBlendOperation : Int16
    Add             = 0
    Subtract        = 1
    ReverseSubtract = 2
    Min             = 3
    Max             = 4
  end
  enum WGPUBufferMapAsyncStatus : Int16
    Success     = 0
    Error       = 1
    Unknown     = 2
    ContextLost = 3
  end
  enum WGPUCompareFunction : Int16
    Never        = 0
    Less         = 1
    Equal        = 2
    LessEqual    = 3
    Greater      = 4
    NotEqual     = 5
    GreaterEqual = 6
    Always       = 7
  end
  enum WGPUCullMode : Int16
    None  = 0
    Front = 1
    Back  = 2
  end
  enum WGPUFilterMode : Int16
    Nearest = 0
    Linear  = 1
  end
  enum WGPUFrontFace : Int16
    Ccw = 0
    Cw  = 1
  end
  enum WGPUIndexFormat : Int16
    Uint16 = 0
    Uint32 = 1
  end
  enum WGPUInputStepMode : Int16
    Vertex   = 0
    Instance = 1
  end
  enum WGPULoadOp : Int16
    Clear = 0
    Load  = 1
  end
  enum WGPUPowerPreference : Int16
    Default         = 0
    LowPower        = 1
    HighPerformance = 2
  end
  enum WGPUPrimitiveTopology : Int16
    PointList     = 0
    LineList      = 1
    LineStrip     = 2
    TriangleList  = 3
    TriangleStrip = 4
  end
  enum WGPUStencilOperation : Int16
    Keep           = 0
    Zero           = 1
    Replace        = 2
    Invert         = 3
    IncrementClamp = 4
    DecrementClamp = 5
    IncrementWrap  = 6
    DecrementWrap  = 7
  end
  enum WGPUStoreOp : Int16
    Store = 0
  end
  enum WGPUTextureDimension : Int16
    D1 = 0
    D2 = 1
    D3 = 2
  end
  enum WGPUTextureFormat : Int16
    R8Unorm        =  0
    R8UnormSrgb    =  1
    R8Snorm        =  2
    R8Uint         =  3
    R8Sint         =  4
    R16Unorm       =  5
    R16Snorm       =  6
    R16Uint        =  7
    R16Sint        =  8
    R16Float       =  9
    Rg8Unorm       = 10
    Rg8UnormSrgb   = 11
    Rg8Snorm       = 12
    Rg8Uint        = 13
    Rg8Sint        = 14
    B5g6r5Unorm    = 15
    R32Uint        = 16
    R32Sint        = 17
    R32Float       = 18
    Rg16Unorm      = 19
    Rg16Snorm      = 20
    Rg16Uint       = 21
    Rg16Sint       = 22
    Rg16Float      = 23
    Rgba8Unorm     = 24
    Rgba8UnormSrgb = 25
    Rgba8Snorm     = 26
    Rgba8Uint      = 27
    Rgba8Sint      = 28
    Bgra8Unorm     = 29
    Bgra8UnormSrgb = 30
    Rgb10a2Unorm   = 31
    Rg11b10Float   = 32
    Rg32Uint       = 33
    Rg32Sint       = 34
    Rg32Float      = 35
    Rgba16Unorm    = 36
    Rgba16Snorm    = 37
    Rgba16Uint     = 38
    Rgba16Sint     = 39
    Rgba16Float    = 40
    Rgba32Uint     = 41
    Rgba32Sint     = 42
    Rgba32Float    = 43
    D16Unorm       = 44
    D32Float       = 45
    D24UnormS8Uint = 46
    D32FloatS8Uint = 47
  end
  enum WGPUTextureViewDimension : Int16
    D1        = 0
    D2        = 1
    D2Array   = 2
    Cube      = 3
    CubeArray = 4
    D3        = 5
  end
  enum WGPUVertexFormat : Int16
    Uchar2      =  1
    Uchar4      =  3
    Char2       =  5
    Char4       =  7
    Uchar2Norm  =  9
    Uchar4Norm  = 11
    Char2Norm   = 14
    Char4Norm   = 16
    Ushort2     = 18
    Ushort4     = 20
    Short2      = 22
    Short4      = 24
    Ushort2Norm = 26
    Ushort4Norm = 28
    Short2Norm  = 30
    Short4Norm  = 32
    Half2       = 34
    Half4       = 36
    Float       = 37
    Float2      = 38
    Float3      = 39
    Float4      = 40
    Uint        = 41
    Uint2       = 42
    Uint3       = 43
    Uint4       = 44
    Int         = 45
    Int2        = 46
    Int3        = 47
    Int4        = 48
  end
  type WGPUTrackPermit = Void
  alias WGPUIndex = UInt32
  alias WGPUEpoch = UInt32

  struct WGPUId
    _0 : WGPUIndex
    _1 : WGPUEpoch
  end

  alias WGPUDeviceId = WGPUId
  alias WGPUAdapterId = WGPUId

  struct WGPUExtensions
    anisotropic_filtering : Bool
  end

  struct WGPULimits
    max_bind_groups : UInt32
  end

  struct WGPUDeviceDescriptor
    extensions : WGPUExtensions
    limits : WGPULimits
  end

  alias WGPUBindGroupId = WGPUId
  alias WGPUBufferId = WGPUId
  alias WGPUBufferAddress = UInt64
  alias WGPUBufferMapReadCallback = (WGPUBufferMapAsyncStatus, UInt8*, UInt8*) -> Void
  alias WGPUBufferMapWriteCallback = (WGPUBufferMapAsyncStatus, UInt8*, UInt8*) -> Void
  alias WGPUCommandBufferId = WGPUId

  struct WGPUBufferCopyView
    buffer : WGPUBufferId
    offset : WGPUBufferAddress
    row_pitch : UInt32
    image_height : UInt32
  end

  alias WGPUTextureId = WGPUId

  struct WGPUOrigin3d
    x : LibC::Float
    y : LibC::Float
    z : LibC::Float
  end

  struct WGPUTextureCopyView
    texture : WGPUTextureId
    mip_level : UInt32
    array_layer : UInt32
    origin : WGPUOrigin3d
  end

  struct WGPUExtent3d
    width : UInt32
    height : UInt32
    depth : UInt32
  end

  alias WGPUComputePassId = WGPUId
  alias WGPUCommandEncoderId = WGPUCommandBufferId
  alias WGPURenderPassId = WGPUId
  alias WGPUTextureViewId = WGPUId

  struct WGPUColor
    r : LibC::Float
    g : LibC::Float
    b : LibC::Float
    a : LibC::Float
  end

  struct WGPURenderPassColorAttachmentDescriptor
    attachment : WGPUTextureViewId
    resolve_target : WGPUTextureViewId*
    load_op : WGPULoadOp
    store_op : WGPUStoreOp
    clear_color : WGPUColor
  end

  struct WGPURenderPassDepthStencilAttachmentDescriptor_TextureViewId
    attachment : WGPUTextureViewId
    depth_load_op : WGPULoadOp
    depth_store_op : WGPUStoreOp
    clear_depth : LibC::Float
    stencil_load_op : WGPULoadOp
    stencil_store_op : WGPUStoreOp
    clear_stencil : UInt32
  end

  struct WGPURenderPassDescriptor
    color_attachments : WGPURenderPassColorAttachmentDescriptor*
    color_attachments_length : LibC::UInt*
    depth_stencil_attachment : WGPURenderPassDepthStencilAttachmentDescriptor_TextureViewId*
  end

  alias WGPURawString = LibC::Char*
  alias WGPUComputePipelineId = WGPUId
  alias WGPUInstanceId = WGPUId
  alias WGPUBindGroupLayoutId = WGPUId

  struct WGPUBufferBinding
    buffer : WGPUBufferId
    offset : WGPUBufferAddress
    size : WGPUBufferAddress
  end

  alias WGPUSamplerId = WGPUId
  enum WGPUBindingResource_Tag : Int16
    BindingResource_Buffer      = 0
    BindingResource_Sampler     = 1
    BindingResource_TextureView = 2
  end

  struct WGPUBindingResource_WGPUBuffer_Body
    _0 : WGPUBufferBinding
  end

  struct WGPUBindingResource_WGPUSampler_Body
    _0 : WGPUSamplerId
  end

  struct WGPUBindingResource_WGPUTextureView_Body
    _0 : WGPUTextureViewId
  end

  struct WGPUBindingResource
    tag : WGPUBindingResource_Tag
  end

  struct WGPUBindGroupBinding
    binding : UInt32
    resource : WGPUBindingResource
  end

  struct WGPUBindGroupDescriptor
    layout : WGPUBindGroupLayoutId
    bindings : WGPUBindGroupBinding*
    bindings_length : LibC::UInt*
  end

  alias WGPUShaderStage = UInt32

  struct WGPUBindGroupLayoutBinding
    binding : UInt32
    visibility : WGPUShaderStage
    ty : WGPUBindingType
  end

  struct WGPUBindGroupLayoutDescriptor
    bindings : WGPUBindGroupLayoutBinding*
    bindings_length : LibC::UInt*
  end

  alias WGPUBufferUsage = UInt32

  struct WGPUBufferDescriptor
    size : WGPUBufferAddress
    usage : WGPUBufferUsage
  end

  struct WGPUCommandEncoderDescriptor
    todo : UInt32
  end

  alias WGPUPipelineLayoutId = WGPUId
  alias WGPUShaderModuleId = WGPUId

  struct WGPUPipelineStageDescriptor
    module : WGPUShaderModuleId
    entry_point : WGPURawString
  end

  struct WGPUComputePipelineDescriptor
    layout : WGPUPipelineLayoutId
    compute_stage : WGPUPipelineStageDescriptor
  end

  struct WGPUPipelineLayoutDescriptor
    bind_group_layouts : WGPUBindGroupLayoutId*
    bind_group_layouts_length : LibC::UInt*
  end

  alias WGPURenderPipelineId = WGPUId

  struct WGPURasterizationStateDescriptor
    front_face : WGPUFrontFace
    cull_mode : WGPUCullMode
    depth_bias : Int32
    depth_bias_slope_scale : LibC::Float
    depth_bias_clamp : LibC::Float
  end

  struct WGPUBlendDescriptor
    src_factor : WGPUBlendFactor
    dst_factor : WGPUBlendFactor
    operation : WGPUBlendOperation
  end

  alias WGPUColorWrite = UInt32

  struct WGPUColorStateDescriptor
    format : WGPUTextureFormat
    alpha_blend : WGPUBlendDescriptor
    color_blend : WGPUBlendDescriptor
    write_mask : WGPUColorWrite
  end

  struct WGPUStencilStateFaceDescriptor
    compare : WGPUCompareFunction
    fail_op : WGPUStencilOperation
    depth_fail_op : WGPUStencilOperation
    pass_op : WGPUStencilOperation
  end

  struct WGPUDepthStencilStateDescriptor
    format : WGPUTextureFormat
    depth_write_enabled : Bool
    depth_compare : WGPUCompareFunction
    stencil_front : WGPUStencilStateFaceDescriptor
    stencil_back : WGPUStencilStateFaceDescriptor
    stencil_read_mask : UInt32
    stencil_write_mask : UInt32
  end

  alias WGPUShaderLocation = UInt32

  struct WGPUVertexAttributeDescriptor
    offset : WGPUBufferAddress
    format : WGPUVertexFormat
    shader_location : WGPUShaderLocation
  end

  struct WGPUVertexBufferDescriptor
    stride : WGPUBufferAddress
    step_mode : WGPUInputStepMode
    attributes : WGPUVertexAttributeDescriptor*
    attributes_length : LibC::UInt*
  end

  struct WGPUVertexInputDescriptor
    index_format : WGPUIndexFormat
    vertex_buffers : WGPUVertexBufferDescriptor*
    vertex_buffers_length : LibC::UInt*
  end

  struct WGPURenderPipelineDescriptor
    layout : WGPUPipelineLayoutId
    vertex_stage : WGPUPipelineStageDescriptor
    fragment_stage : WGPUPipelineStageDescriptor*
    primitive_topology : WGPUPrimitiveTopology
    rasterization_state : WGPURasterizationStateDescriptor
    color_states : WGPUColorStateDescriptor*
    color_states_length : LibC::UInt*
    depth_stencil_state : WGPUDepthStencilStateDescriptor*
    vertex_input : WGPUVertexInputDescriptor
    sample_count : UInt32
  end

  struct WGPUSamplerDescriptor
    address_mode_u : WGPUAddressMode
    address_mode_v : WGPUAddressMode
    address_mode_w : WGPUAddressMode
    mag_filter : WGPUFilterMode
    min_filter : WGPUFilterMode
    mipmap_filter : WGPUFilterMode
    lod_min_clamp : LibC::Float
    lod_max_clamp : LibC::Float
    compare_function : WGPUCompareFunction
  end

  struct WGPUByteArray
    bytes : UInt8*
    length : LibC::UInt*
  end

  struct WGPUShaderModuleDescriptor
    code : WGPUByteArray
  end

  alias WGPUSurfaceId = WGPUId
  alias WGPUSwapChainId = WGPUSurfaceId
  alias WGPUTextureUsage = UInt32

  struct WGPUSwapChainDescriptor
    usage : WGPUTextureUsage
    format : WGPUTextureFormat
    width : UInt32
    height : UInt32
  end

  struct WGPUTextureDescriptor
    size : WGPUExtent3d
    array_layer_count : UInt32
    mip_level_count : UInt32
    sample_count : UInt32
    dimension : WGPUTextureDimension
    format : WGPUTextureFormat
    usage : WGPUTextureUsage
  end

  alias WGPUQueueId = WGPUDeviceId

  struct WGPUAdapterDescriptor
    power_preference : WGPUPowerPreference
  end

  struct WGPUSwapChainOutput
    texture_id : WGPUTextureId
    view_id : WGPUTextureViewId
  end

  alias WGPUTextureAspectFlags = UInt32

  struct WGPUTextureViewDescriptor
    format : WGPUTextureFormat
    dimension : WGPUTextureViewDimension
    aspect : WGPUTextureAspectFlags
    base_mip_level : UInt32
    level_count : UInt32
    base_array_layer : UInt32
    array_count : UInt32
  end

  fun wgpu_adapter_request_device(WGPUAdapterId, WGPUDeviceDescriptor*) : WGPUDeviceId
  fun wgpu_bind_group_destroy(WGPUBindGroupId) : Void
  fun wgpu_buffer_destroy(WGPUBufferId) : Void
  fun wgpu_buffer_map_read_async(WGPUBufferId, WGPUBufferAddress, WGPUBufferAddress, WGPUBufferMapReadCallback, UInt8*) : Void
  fun wgpu_buffer_map_write_async(WGPUBufferId, WGPUBufferAddress, WGPUBufferAddress, WGPUBufferMapWriteCallback, UInt8*) : Void
  fun wgpu_buffer_unmap(WGPUBufferId) : Void
  fun wgpu_command_buffer_copy_buffer_to_buffer(WGPUCommandBufferId, WGPUBufferId, WGPUBufferAddress, WGPUBufferId, WGPUBufferAddress, WGPUBufferAddress) : Void
  fun wgpu_command_buffer_copy_buffer_to_texture(WGPUCommandBufferId, WGPUBufferCopyView*, WGPUTextureCopyView*, WGPUExtent3d) : Void
  fun wgpu_command_buffer_copy_texture_to_buffer(WGPUCommandBufferId, WGPUTextureCopyView*, WGPUBufferCopyView*, WGPUExtent3d) : Void
  fun wgpu_command_buffer_copy_texture_to_texture(WGPUCommandBufferId, WGPUTextureCopyView*, WGPUTextureCopyView*, WGPUExtent3d) : Void
  fun wgpu_command_encoder_begin_compute_pass(WGPUCommandEncoderId) : WGPUComputePassId
  fun wgpu_command_encoder_begin_render_pass(WGPUCommandEncoderId, WGPURenderPassDescriptor*) : WGPURenderPassId
  fun wgpu_command_encoder_finish(WGPUCommandEncoderId) : WGPUCommandBufferId
  fun wgpu_compute_pass_dispatch(WGPUComputePassId, UInt32, UInt32, UInt32) : Void
  fun wgpu_compute_pass_end_pass(WGPUComputePassId) : WGPUCommandBufferId
  fun wgpu_compute_pass_insert_debug_marker(WGPUComputePassId, WGPURawString) : Void
  fun wgpu_compute_pass_pop_debug_group(WGPUComputePassId) : Void
  fun wgpu_compute_pass_push_debug_group(WGPUComputePassId, WGPURawString) : Void
  fun wgpu_compute_pass_set_bind_group(WGPUComputePassId, UInt32, WGPUBindGroupId, WGPUBufferAddress*, LibC::UInt*) : Void
  fun wgpu_compute_pass_set_pipeline(WGPUComputePassId, WGPUComputePipelineId) : Void
  fun wgpu_create_instance : WGPUInstanceId
  fun wgpu_device_create_bind_group(WGPUDeviceId, WGPUBindGroupDescriptor*) : WGPUBindGroupId
  fun wgpu_device_create_bind_group_layout(WGPUDeviceId, WGPUBindGroupLayoutDescriptor*) : WGPUBindGroupLayoutId
  fun wgpu_device_create_buffer(WGPUDeviceId, WGPUBufferDescriptor*) : WGPUBufferId
  fun wgpu_device_create_buffer_mapped(WGPUDeviceId, WGPUBufferDescriptor*, UInt8**) : WGPUBufferId
  fun wgpu_device_create_command_encoder(WGPUDeviceId, WGPUCommandEncoderDescriptor*) : WGPUCommandEncoderId
  fun wgpu_device_create_compute_pipeline(WGPUDeviceId, WGPUComputePipelineDescriptor*) : WGPUComputePipelineId
  fun wgpu_device_create_pipeline_layout(WGPUDeviceId, WGPUPipelineLayoutDescriptor*) : WGPUPipelineLayoutId
  fun wgpu_device_create_render_pipeline(WGPUDeviceId, WGPURenderPipelineDescriptor*) : WGPURenderPipelineId
  fun wgpu_device_create_sampler(WGPUDeviceId, WGPUSamplerDescriptor*) : WGPUSamplerId
  fun wgpu_device_create_shader_module(WGPUDeviceId, WGPUShaderModuleDescriptor*) : WGPUShaderModuleId
  fun wgpu_device_create_swap_chain(WGPUDeviceId, WGPUSurfaceId, WGPUSwapChainDescriptor*) : WGPUSwapChainId
  fun wgpu_device_create_texture(WGPUDeviceId, WGPUTextureDescriptor*) : WGPUTextureId
  fun wgpu_device_destroy(WGPUDeviceId) : Void
  fun wgpu_device_get_queue(WGPUDeviceId) : WGPUQueueId
  fun wgpu_device_poll(WGPUDeviceId, Bool) : Void
  fun wgpu_instance_create_surface_from_macos_layer(WGPUInstanceId, Void*) : WGPUSurfaceId
  fun wgpu_instance_create_surface_from_windows_hwnd(WGPUInstanceId, Void*, Void*) : WGPUSurfaceId
  fun wgpu_instance_create_surface_from_xlib(WGPUInstanceId, Void**, UInt64) : WGPUSurfaceId
  fun wgpu_instance_get_adapter(WGPUInstanceId, WGPUAdapterDescriptor*) : WGPUAdapterId
  fun wgpu_queue_submit(WGPUQueueId, WGPUCommandBufferId*, LibC::UInt*) : Void
  fun wgpu_render_pass_draw(WGPURenderPassId, UInt32, UInt32, UInt32, UInt32) : Void
  fun wgpu_render_pass_draw_indexed(WGPURenderPassId, UInt32, UInt32, UInt32, Int32, UInt32) : Void
  fun wgpu_render_pass_end_pass(WGPURenderPassId) : WGPUCommandBufferId
  fun wgpu_render_pass_insert_debug_marker(WGPURenderPassId, WGPURawString) : Void
  fun wgpu_render_pass_pop_debug_group(WGPURenderPassId) : Void
  fun wgpu_render_pass_push_debug_group(WGPURenderPassId, WGPURawString) : Void
  fun wgpu_render_pass_set_bind_group(WGPURenderPassId, UInt32, WGPUBindGroupId, WGPUBufferAddress*, LibC::UInt*) : Void
  fun wgpu_render_pass_set_blend_color(WGPURenderPassId, WGPUColor*) : Void
  fun wgpu_render_pass_set_index_buffer(WGPURenderPassId, WGPUBufferId, WGPUBufferAddress) : Void
  fun wgpu_render_pass_set_pipeline(WGPURenderPassId, WGPURenderPipelineId) : Void
  fun wgpu_render_pass_set_scissor_rect(WGPURenderPassId, UInt32, UInt32, UInt32, UInt32) : Void
  fun wgpu_render_pass_set_stencil_reference(WGPURenderPassId, UInt32) : Void
  fun wgpu_render_pass_set_vertex_buffers(WGPURenderPassId, WGPUBufferId*, WGPUBufferAddress*, LibC::UInt*) : Void
  fun wgpu_render_pass_set_viewport(WGPURenderPassId, LibC::Float, LibC::Float, LibC::Float, LibC::Float, LibC::Float, LibC::Float) : Void
  fun wgpu_swap_chain_get_next_texture(WGPUSwapChainId) : WGPUSwapChainOutput
  fun wgpu_swap_chain_present(WGPUSwapChainId) : Void
  fun wgpu_texture_create_default_view(WGPUTextureId) : WGPUTextureViewId
  fun wgpu_texture_create_view(WGPUTextureId, WGPUTextureViewDescriptor*) : WGPUTextureViewId
  fun wgpu_texture_destroy(WGPUTextureId) : Void
  fun wgpu_texture_view_destroy(WGPUTextureViewId) : Void
end
