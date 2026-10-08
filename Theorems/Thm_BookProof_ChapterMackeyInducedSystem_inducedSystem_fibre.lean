-- Generated from ChapterMackeyInducedSystem.lean — theorem BookProof.ChapterMackeyInducedSystem.inducedSystem_fibre
import Definitions.Def_ChapterMackeyImprimitivity
import Mathlib
import Definitions.Def_ChapterMackeyInducedSystem
open BookProof.ChapterMackeyInducedSystem


open scoped InnerProductSpace
open Finset


open BookProof.ChapterMackeyImprimitivity

variable {G : Type*} [Group G] {X : Type*} [Fintype X] [DecidableEq X] [MulAction G X]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable {x₀ : X}

variable {L : MulAction.stabilizer G x₀ →* (K ≃ₗᵢ[ℂ] K)} {s : X → G}
variable (L s)
variable {L s}
variable (X K) in

theorem BookProof.ChapterMackeyInducedSystem.inducedSystem_fibre (L : MulAction.stabilizer G x₀ →* (K ≃ₗᵢ[ℂ] K)) (s : X → G)
    (hs : ∀ x, s x • x₀ = x) (f : FieldSpace X K) :
    (inducedSystem L s hs).p x₀ f = f ↔ ∀ x, x ≠ x₀ → f x = 0 := by sorry
