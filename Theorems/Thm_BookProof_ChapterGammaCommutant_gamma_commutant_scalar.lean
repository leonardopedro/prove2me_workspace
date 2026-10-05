-- Generated from ChapterGammaCommutant.lean — theorem BookProof.ChapterGammaCommutant.gamma_commutant_scalar
import Mathlib
import Definitions.Def_ChapterGammaCommutant
import Definitions.Def_ChapterA3
open BookProof.ChapterA3
open BookProof.ChapterGammaCommutant


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterGammaCommutant.gamma_commutant_scalar (X : Matrix (Fin 4) (Fin 4) ℂ)
    (h : ∀ μ, X * mgamma μ = mgamma μ * X) :
    X = X 0 0 • (1 : Matrix (Fin 4) (Fin 4) ℂ) := by sorry
