-- Generated from ChapterQgMultiHalfDensity.lean — solution of BookProof.QgMultiHalfDensity.mpUnitary_intertwines_multOp
import Mathlib
import Definitions.Def_ChapterQgMultiHalfDensity
import Theorems.Thm_BookProof_QgMultiHalfDensity_mpUnitary_apply
import Theorems.Thm_BookProof_QgMultiHalfDensity_mpUnitary_mem_boundedEnergyCore
import Theorems.Thm_BookProof_ChapterLinftyMultiplication_multOp_coeFn
open BookProof.QgMultiHalfDensity




open MeasureTheory Set
open BookProof.NavierStokesFlow.FockContinuum
open BookProof.QuantumGravityHalfDensity

noncomputable section

variable {X Y : Type*} [MeasurableSpace X] [MeasurableSpace Y]
  {mu : Measure X} {nu : Measure Y} {Phi : X → Y} {Psi : Y → X}
variable {g : Y → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hPhi : MeasurePreserving Phi mu nu)
    (hPsi : MeasurePreserving Psi nu mu) (hinv : ∀ᵐ x ∂mu, Psi (Phi x) = x)
    (hg : Measurable g) (x : boundedEnergyCore nu g) :
    ((multOp mu (hg.comp hPhi.measurable)
        ⟨mpUnitary hPhi hPsi hinv (x : Lp ℂ 2 nu),
          mpUnitary_mem_boundedEnergyCore hPhi hPsi hinv x⟩ :
        boundedEnergyCore mu (fun t => g (Phi t))) : Lp ℂ 2 mu)
      = mpUnitary hPhi hPsi hinv ((multOp nu hg x : boundedEnergyCore nu g) : Lp ℂ 2 nu) := by

  refine Lp.ext ?_
  have h1 := multOp_coeFn mu (hg.comp hPhi.measurable)
    (⟨mpUnitary hPhi hPsi hinv (x : Lp ℂ 2 nu),
      mpUnitary_mem_boundedEnergyCore hPhi hPsi hinv x⟩ :
      boundedEnergyCore mu (fun t => g (Phi t)))
  have h2 := mpUnitary_apply hPhi hPsi hinv (x : Lp ℂ 2 nu)
  have h3 := mpUnitary_apply hPhi hPsi hinv
    ((multOp nu hg x : boundedEnergyCore nu g) : Lp ℂ 2 nu)
  have h4 := (multOp_coeFn nu hg x).comp_tendsto hPhi.quasiMeasurePreserving.tendsto_ae
  filter_upwards [h1, h2, h3, h4] with t ht1 ht2 ht3 ht4
  simp only [Function.comp_apply] at ht4
  refine ht1.trans ?_
  rw [ht2, ht3, ht4]
  rfl
