-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — solution of BookProof.NavierStokesFlow.HermiteFarisLavine.abs_le_of_hasSum
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine



open scoped ENNReal



open LpNat FarisLavine IkebeKato

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}

set_option maxHeartbeats 1000000 in
theorem solution {f g : ℕ → ℝ} {S T : ℝ} (hf : HasSum f S) (hg : HasSum g T)
    (h : ∀ n, |f n| ≤ g n) : |S| ≤ T := by

  refine abs_le.mpr ⟨?_, hasSum_le (fun n => le_trans (le_abs_self _) (h n)) hf hg⟩
  have hneg : HasSum (fun n => -g n) (-T) := hg.neg
  have := hasSum_le (fun n => by linarith [neg_abs_le (f n), h n] : ∀ n, -g n ≤ f n) hneg hf
  linarith
