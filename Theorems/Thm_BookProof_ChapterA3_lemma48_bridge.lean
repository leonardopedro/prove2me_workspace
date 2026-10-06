-- Generated from ChapterA3i.lean — theorem BookProof.ChapterA3.lemma48_bridge
import Mathlib
import Definitions.Def_ChapterA3i
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.lemma48_bridge (T : Matrix (Fin 2) (Fin 2) ℂ)
    (hdet : T 0 0 * T 1 1 - T 0 1 * T 1 0 = 1) (μ : Fin 4) :
    (Spinor T)⁻¹ * mgamma μ * Spinor T = ∑ ν, UpsilonC T ν μ • mgamma ν := by sorry
