-- Generated from ChapterFockCubicQuarticStability.lean — solution of BookProof.FockCubicQuarticStability.cubic_form_eq
import Mathlib
import Definitions.Def_ChapterFockCubicQuarticStability
import Theorems.Thm_BookProof_FockCubicUnbounded_cubeA_apply
import Theorems.Thm_BookProof_FockSecondQuantization_inner_creA_right
open BookProof.FockCubicQuarticStability



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicUnbounded

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (u : FockAlg) :
    (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
      = 2 * (inner ℂ (toLp (annA k (annA k u))) (toLp (creA k u)) : ℂ).re := by

  have hadd : ∀ a b : FockAlg, toLp (a + b) = toLp a + toLp b := fun a b => map_add toLpL a b
  have hcre : (inner ℂ (toLp u) (toLp (creA k (creA k (creA k u)))) : ℂ)
      = inner ℂ (toLp (annA k (annA k u))) (toLp (creA k u)) := by
    rw [inner_creA_right, inner_creA_right]
  have hann : (inner ℂ (toLp (annA k (annA k u))) (toLp (creA k u)) : ℂ)
      = inner ℂ (toLp (annA k (annA k (annA k u)))) (toLp u) := by
    rw [inner_creA_right]
  have hann' : (inner ℂ (toLp u) (toLp (annA k (annA k (annA k u)))) : ℂ)
      = (starRingEnd ℂ) (inner ℂ (toLp (annA k (annA k u))) (toLp (creA k u))) := by
    rw [hann, inner_conj_symm]
  rw [cubeA_apply, hadd, inner_add_right, Complex.add_re, hcre, hann', Complex.conj_re]
  ring
