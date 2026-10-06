-- Generated from ChapterA4f.lean — theorem BookProof.ChapterA4f.zeroMomentum_symbol
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterA4f
import Definitions.Def_ChapterA5
open BookProof.ChapterA5
open BookProof.ChapterA4f


open Matrix
open scoped ComplexConjugate


open BookProof.ChapterA3 BookProof.ChapterA5

theorem BookProof.ChapterA4f.zeroMomentum_symbol (m₁ m₂ : ℝ) :
    energySymbolR (fun _ => 0) m₁ m₂ * energySymbolR (fun _ => 0) m₁ m₂
      = (-(m₁ ^ 2 + m₂ ^ 2)) • (1 : Matrix (Fin 4) (Fin 4) ℝ) := by sorry
