-- Generated from ChapterGammaCommutant.lean — theorem BookProof.ChapterGammaCommutant.gamma_intertwiner_unique
import Mathlib
import Definitions.Def_ChapterGammaCommutant
import Definitions.Def_ChapterA3
open BookProof.ChapterA3
open BookProof.ChapterGammaCommutant


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterGammaCommutant.gamma_intertwiner_unique (S T : Matrix (Fin 4) (Fin 4) ℂ) (hS : IsUnit S.det)
    (hSg : ∀ μ, S * mgamma μ = mgamma μ * S) (hTg : ∀ μ, T * mgamma μ = mgamma μ * T) :
    ∃ c : ℂ, T = c • S := by sorry
