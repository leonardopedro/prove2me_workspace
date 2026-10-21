-- Generated from ChapterFockCubicUnbounded.lean — solution of BookProof.FockCubicUnbounded.cubeA_coord
import Mathlib
import Definitions.Def_ChapterFockCubicUnbounded
import Theorems.Thm_BookProof_FockCubicUnbounded_cubeA_apply
import Theorems.Thm_BookProof_FockSecondQuantization_annA_apply
import Theorems.Thm_BookProof_FockSecondQuantization_creA_apply
open BookProof.FockCubicUnbounded



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (x : FockAlg) (γ : Conf) :
    cubeA k x γ
      = ((Real.sqrt (γ k) : ℝ) : ℂ) * ((Real.sqrt ((dn k γ) k) : ℝ) : ℂ)
          * ((Real.sqrt ((dn k (dn k γ)) k) : ℝ) : ℂ) * x (dn k (dn k (dn k γ)))
        + ((Real.sqrt ((γ k : ℝ) + 1) : ℝ) : ℂ)
            * ((Real.sqrt (((up k γ) k : ℝ) + 1) : ℝ) : ℂ)
            * ((Real.sqrt (((up k (up k γ)) k : ℝ) + 1) : ℝ) : ℂ)
            * x (up k (up k (up k γ))) := by

  rw [cubeA_apply, Finsupp.add_apply, creA_apply, creA_apply, creA_apply,
    annA_apply, annA_apply, annA_apply]
  ring
