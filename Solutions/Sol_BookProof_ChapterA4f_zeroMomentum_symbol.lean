-- Generated from ChapterA4f.lean — solution of BookProof.ChapterA4f.zeroMomentum_symbol
import Mathlib
import Definitions.Def_ChapterA4f
open BookProof.ChapterA4f



open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3 BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution (m₁ m₂ : ℝ) :
    energySymbolR (fun _ => 0) m₁ m₂ * energySymbolR (fun _ => 0) m₁ m₂
      = (-(m₁ ^ 2 + m₂ ^ 2)) • (1 : Matrix (Fin 4) (Fin 4) ℝ) := by

        -- Apply the energySymbolR_sq theorem with p being the zero function.
        have := energySymbolR_sq (fun _ => 0) m₁ m₂;
        simp only [ne_eq, OfNat.ofNat_ne_zero, not_false_eq_true, zero_pow, add_zero,
          zero_sub] at this;
        exact this ▸ by ring;
