-- Generated from ChapterL2TensorPowerUnitary.lean — theorem BookProof.L2TensorPower.l2dSpace_eq
import Definitions.Def_ChapterNsScalarVectorCurry
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Mathlib
import Definitions.Def_ChapterL2TensorPowerUnitary
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterTensorGraphCore
open BookProof.HermiteProductCore
open BookProof.TensorCore
open BookProof.L2TensorPower



open MeasureTheory BookProof.TensorCore BookProof.NsScalarVectorCurry
open BookProof.SecondQuantizationCore
open scoped TensorProduct

noncomputable section


variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W} [SigmaFinite μ] [SigmaFinite ν]

variable {V : Type} [MeasurableSpace V] (μ : Measure V) [SigmaFinite μ]

theorem BookProof.L2TensorPower.l2dSpace_eq (d : ℕ) :
    BookProof.YangMillsNonAbelianEsa.L2dSpace d = L2Space (volume : Measure (Vd d)) := by sorry
