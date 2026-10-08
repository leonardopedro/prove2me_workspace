-- Generated from ChapterL2TensorPowerUnitary.lean — solution of BookProof.L2TensorPower.tensorPowUnitary_coe
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
theorem solution (n : ℕ) (x : ((L2Space μ).pow n).carrier) :
    tensorPowUnitary μ n (x : fockSector (L2Space μ) n) = embPow μ n x := LinearEquiv.extendOfIsometry_eq _ _ _ _ _ _ x
