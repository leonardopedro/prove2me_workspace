-- Generated from ChapterA3b.lean — theorem BookProof.ChapterA3.lorentz_of_conj
import Mathlib
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA3
open BookProof.ChapterA3


open Matrix
open scoped ComplexConjugate

theorem BookProof.ChapterA3.lorentz_of_conj (S : Matrix (Fin 4) (Fin 4) ℂ) (hS : IsUnit S.det)
    (Lam : Matrix (Fin 4) (Fin 4) ℝ)
    (hLam : ∀ μ, S⁻¹ * mgamma μ * S = ∑ ν, (Lam μ ν : ℂ) • mgamma ν) :
    Lam * minkowskiMat * Lamᵀ = minkowskiMat := by sorry
