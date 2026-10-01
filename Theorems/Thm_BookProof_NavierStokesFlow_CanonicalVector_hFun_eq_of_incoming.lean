-- Generated from ChapterNavierStokesCanonicalVector.lean — theorem BookProof.NavierStokesFlow.CanonicalVector.hFun_eq_of_incoming
import Mathlib
import Definitions.Def_ChapterNavierStokesCanonicalVector
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.CanonicalVector

variable (A : Matrix (Fin 3) (Fin 3) ℝ) (c : Fin 3 → ℝ)


open scoped ENNReal



open LpNat FarisLavine IkebeKato ThreeComponent ShiftHamiltonian SignedShift

theorem BookProof.NavierStokesFlow.CanonicalVector.hFun_eq_of_incoming {sym : Vel → ℝ} (S : SignedHop Vel sym) (X g : Vel → ℂ)
    (h1 : ∀ β, g (S.shift β) = (S.amp β : ℂ) * X β)
    (h2 : ∀ γ, (¬ ∃ α, S.shift α = γ) → g γ = 0) (γ : Vel) :
    S.hFun X γ = Complex.I * (g γ - (S.amp γ : ℂ) * X (S.shift γ)) := by sorry
