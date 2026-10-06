-- Generated from ChapterProve2meReuse.lean — solution of BookProof.Prove2meReuse.lagrangian_det_add_two
import Mathlib
import Definitions.Def_ChapterProve2meReuse
open BookProof.Prove2meReuse



open MeasureTheory
open scoped Convolution

set_option maxHeartbeats 1000000 in
theorem solution (H : RouteHypotheses) :
    DetAddTwo := H.det_add_two
