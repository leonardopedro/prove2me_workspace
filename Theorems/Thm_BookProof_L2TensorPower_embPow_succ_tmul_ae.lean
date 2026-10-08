-- Generated from ChapterL2TensorPowerUnitary.lean — theorem BookProof.L2TensorPower.embPow_succ_tmul_ae
import Definitions.Def_ChapterTensorGraphCore
import Definitions.Def_ChapterNsScalarVectorCurry
import Definitions.Def_ChapterSecondQuantizationCoreEsa
import Mathlib
import Definitions.Def_ChapterL2TensorPowerUnitary
open BookProof.L2TensorPower



open MeasureTheory BookProof.TensorCore BookProof.NsScalarVectorCurry
open BookProof.SecondQuantizationCore
open scoped TensorProduct

noncomputable section


variable {V W : Type*} [MeasurableSpace V] [MeasurableSpace W]
  {μ : Measure V} {ν : Measure W} [SigmaFinite μ] [SigmaFinite ν]

variable {V : Type} [MeasurableSpace V] (μ : Measure V) [SigmaFinite μ]

theorem BookProof.L2TensorPower.embPow_succ_tmul_ae (n : ℕ) (a : Lp ℂ 2 μ) (t : ((L2Space μ).pow n).carrier) :
    (embPow μ (n + 1) (a ⊗ₜ[ℂ] t) : (Fin (n + 1) → V) → ℂ) =ᵐ[piMeasure μ (n + 1)]
      fun x => (a : V → ℂ) (x 0) * (embPow μ n t : (Fin n → V) → ℂ) (Fin.tail x) := by sorry
