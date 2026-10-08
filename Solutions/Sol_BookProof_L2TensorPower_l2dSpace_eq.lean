-- Generated from ChapterL2TensorPowerUnitary.lean — solution of BookProof.L2TensorPower.l2dSpace_eq
import Mathlib
import Definitions.Def_ChapterL2TensorPowerUnitary
open BookProof.L2TensorPower




open MeasureTheory BookProof.TensorCore BookProof.NsScalarVectorCurry
open BookProof.SecondQuantizationCore
open scoped TensorProduct

noncomputable section


variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W} [SigmaFinite μ] [SigmaFinite ν]

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W} [SigmaFinite μ] [SigmaFinite ν]
variable {V : Type} [MeasurableSpace V] (μ : Measure V) [SigmaFinite μ]

set_option maxHeartbeats 1000000 in
theorem solution (d : ℕ) :
    BookProof.YangMillsNonAbelianEsa.L2dSpace d = L2Space (volume : Measure (Vd d)) := rfl
