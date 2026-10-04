-- Generated from ChapterMackeyInducedSystem.lean — theorem BookProof.ChapterMackeyInducedSystem.inducedSystem_stabilizer_rep
import Mathlib
import Definitions.Def_ChapterMackeyInducedSystem
import Definitions.Def_ChapterMackeyImprimitivity
import Definitions.Def_ChapterA4
open BookProof.ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity.ImprimitivitySystem
open BookProof.ChapterMackeyInducedSystem

variable {G : Type*} [Group G] {X : Type*} [Fintype X] [DecidableEq X] [MulAction G X]
variable {K : Type*} [NormedAddCommGroup K] [InnerProductSpace ℂ K]
variable {x₀ : X}
variable {L : MulAction.stabilizer G x₀ →* (K ≃ₗᵢ[ℂ] K)} {s : X → G}
variable (L s)
variable {L s}
variable (X K) in


open scoped InnerProductSpace
open Finset


open BookProof.ChapterMackeyImprimitivity


theorem BookProof.ChapterMackeyInducedSystem.inducedSystem_stabilizer_rep (L : MulAction.stabilizer G x₀ →* (K ≃ₗᵢ[ℂ] K)) (s : X → G)
    (hs : ∀ x, s x • x₀ = x) (hs0 : s x₀ = 1) (a : MulAction.stabilizer G x₀)
    (f : FieldSpace X K) :
    ((inducedSystem L s hs).U (a : G) f) x₀ = L a (f x₀) := by sorry
