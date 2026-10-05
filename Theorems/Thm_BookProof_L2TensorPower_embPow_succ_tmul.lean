-- Generated from ChapterL2TensorPowerUnitary.lean — theorem BookProof.L2TensorPower.embPow_succ_tmul
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



theorem BookProof.L2TensorPower.embPow_succ_tmul (n : ℕ) (a : Lp ℂ 2 μ) (t : ((L2Space μ).pow n).carrier) :
    embPow μ (n + 1) (a ⊗ₜ[ℂ] t) = splitIso μ n (prodMk a (embPow μ n t)) := by sorry
