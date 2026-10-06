-- Generated from ChapterMackeyImprimitivity.lean — theorem BookProof.ChapterMackeyImprimitivity.mackey_imprimitivity
import Mathlib
import Definitions.Def_ChapterMackeyImprimitivity
open BookProof.ChapterMackeyImprimitivity

variable {G : Type*} [Group G] {X : Type*} [Fintype X] [MulAction G X]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
variable (S : ImprimitivitySystem G X E)
variable (S : ImprimitivitySystem G X E) (x₀ : X) (s : X → G)
variable {S x₀ s}


open scoped InnerProductSpace
open Finset



theorem BookProof.ChapterMackeyImprimitivity.mackey_imprimitivity [DecidableEq X] (S : ImprimitivitySystem G X E) (x₀ : X) (s : X → G)
    (hs : ∀ x, s x • x₀ = x) :
    (∀ ψ φ : E, mackeyMap S s (ψ + φ) = mackeyMap S s ψ + mackeyMap S s φ) ∧
    (∀ (a : ℂ) (ψ : E), mackeyMap S s (a • ψ) = a • mackeyMap S s ψ) ∧
    (∀ ψ : E, mackeyMap S s ψ ∈ InducedSpace S x₀) ∧
    (∀ ψ : E, ∑ x : X, ‖mackeyMap S s ψ x‖ ^ 2 = ‖ψ‖ ^ 2) ∧
    Function.Injective (mackeyMap S s) ∧
    (∀ f ∈ InducedSpace S x₀, ∃ ψ : E, mackeyMap S s ψ = f) ∧
    (∀ (g : G) (ψ : E), mackeyMap S s (S.U g ψ) = inducedRep S s g (mackeyMap S s ψ)) ∧
    (∀ (y : X) (ψ : E), mackeyMap S s (S.p y ψ) = inducedPvm y (mackeyMap S s ψ)) := by sorry
