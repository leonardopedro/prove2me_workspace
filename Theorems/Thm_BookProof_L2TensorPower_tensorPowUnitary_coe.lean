-- Generated from ChapterL2TensorPowerUnitary.lean — theorem BookProof.L2TensorPower.tensorPowUnitary_coe
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterNsScalarVectorCurry
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Mathlib
import Definitions.Def_ChapterL2TensorPowerUnitary
open BookProof.L2TensorPower

variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W} [SigmaFinite μ] [SigmaFinite ν]
variable (μ ν) in
variable {V : Type} [MeasurableSpace V] (μ : Measure V) [SigmaFinite μ]



open MeasureTheory BookProof.TensorCore BookProof.NsScalarVectorCurry
open BookProof.SecondQuantizationCore
open scoped TensorProduct

noncomputable section



theorem BookProof.L2TensorPower.tensorPowUnitary_coe (n : ℕ) (x : ((L2Space μ).pow n).carrier) :
    tensorPowUnitary μ n (x : fockSector (L2Space μ) n) = embPow μ n x := by sorry
