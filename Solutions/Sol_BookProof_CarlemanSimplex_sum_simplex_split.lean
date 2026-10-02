-- Generated from ChapterCarlemanSimplex.lean — solution of BookProof.CarlemanSimplex.sum_simplex_split
import Mathlib
import Definitions.Def_ChapterCarlemanSimplex




open Finset

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (d N k : ℕ) (F : (Fin d →₀ ℕ) → ℂ) :
    ∑ a ∈ simplexF d N, F a = ∑ a ∈ sInn d N k, F a + ∑ a ∈ sBd d N k, F a := by

  classical
  rw [sInn, sBd,
    ← Finset.sum_filter_add_sum_filter_not (simplexF d N) (fun a => deg a + k ≤ N) F]
  congr 1
  refine Finset.sum_congr ?_ fun _ _ => rfl
  ext a
  simp only [Finset.mem_filter]
  constructor
  · rintro ⟨h1, h2⟩; exact ⟨h1, by omega⟩
  · rintro ⟨h1, h2⟩; exact ⟨h1, by omega⟩
