-- Generated from ChapterA3h.lean — theorem BookProof.ChapterA3.upsilon_apply_comb
import Mathlib
import Definitions.Def_ChapterA3h
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.upsilon_apply_comb (T : Matrix (Fin 2) (Fin 2) ℂ) (x : Fin 4 → ℂ) :
    Tᴴ * (∑ ν, x ν • pauliσ ν) * T = ∑ μ, (∑ ν, UpsilonC T μ ν * x ν) • pauliσ μ := by sorry
