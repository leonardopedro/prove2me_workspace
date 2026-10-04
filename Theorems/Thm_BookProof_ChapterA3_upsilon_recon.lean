-- Generated from ChapterA3h.lean — theorem BookProof.ChapterA3.upsilon_recon
import Mathlib
import Definitions.Def_ChapterA3h
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.upsilon_recon (T : Matrix (Fin 2) (Fin 2) ℂ) (ν : Fin 4) :
    Tᴴ * pauliσ ν * T = ∑ μ, UpsilonC T μ ν • pauliσ μ := by sorry
