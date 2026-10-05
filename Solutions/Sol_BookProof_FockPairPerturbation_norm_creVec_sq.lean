-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.norm_creVec_sq
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Theorems.Thm_BookProof_FockPairPerturbation_annVec_creVec
import Theorems.Thm_BookProof_FockPairPerturbation_inner_creVec_left
import Theorems.Thm_BookProof_FockFieldPerturbation_inner_creVec_annVec
open BookProof.FockPairPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution (g : ℕ →₀ ℂ) (u : FockAlg) :
    ‖toLp (creVec g u)‖ ^ 2 = ‖toLp (annVec g u)‖ ^ 2 + l2sq g * ‖toLp u‖ ^ 2 := by

  have hadd : ∀ a b : FockAlg, toLp (a + b) = toLp a + toLp b := fun a b => map_add toLpL a b
  have hsmul : ∀ (c : ℂ) (a : FockAlg), toLp (c • a) = c • toLp a := fun c a =>
    map_smul toLpL c a
  have key : (inner ℂ (toLp (creVec g u)) (toLp (creVec g u)) : ℂ)
      = inner ℂ (toLp (annVec g u)) (toLp (annVec g u))
        + ((l2sq g : ℝ) : ℂ) * inner ℂ (toLp u) (toLp u) := by
    rw [inner_creVec_annVec g (creVec g u) u, annVec_creVec g u, hadd, hsmul,
      inner_add_left, inner_smul_left, inner_creVec_left g (annVec g u) u,
      Complex.conj_ofReal]
  rw [inner_self_eq_norm_sq_to_K, inner_self_eq_norm_sq_to_K, inner_self_eq_norm_sq_to_K] at key
  have hcast : ((‖toLp (creVec g u)‖ ^ 2 : ℝ) : ℂ)
      = ((‖toLp (annVec g u)‖ ^ 2 + l2sq g * ‖toLp u‖ ^ 2 : ℝ) : ℂ) := by
    push_cast
    exact key
  exact_mod_cast hcast
