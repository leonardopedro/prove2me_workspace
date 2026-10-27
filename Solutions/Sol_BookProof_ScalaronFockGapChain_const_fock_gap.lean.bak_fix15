-- Generated from ChapterScalaronFockGapChain.lean — solution of BookProof.ScalaronFockGapChain.const_fock_gap
import Mathlib
import Definitions.Def_ChapterScalaronFockGapChain
import Theorems.Thm_BookProof_ScalaronFockGapChain_constOnePart_quadForm
import Theorems.Thm_BookProof_FockNumberPreservingGap_fock_gap_of_one_particle_form_gap
open BookProof.ScalaronFockGapChain



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicQuarticStability BookProof.FockCubicUnbounded
open BookProof.FockInteractionStability
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) {m : ℝ} (hm : 0 ≤ m) :
    dGamma (opCol b (constOnePart b m)) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        m * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma (opCol b (constOnePart b m)) u)) : ℂ).re :=
  fock_gap_of_one_particle_form_gap b (constOnePart b m) hm
      fun x => (constOnePart_quadForm b m x).ge
