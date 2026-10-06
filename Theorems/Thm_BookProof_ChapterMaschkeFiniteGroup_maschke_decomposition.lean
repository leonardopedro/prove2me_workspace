-- Generated from ChapterMaschkeFiniteGroup.lean — theorem BookProof.ChapterMaschkeFiniteGroup.maschke_decomposition
import Mathlib
import Definitions.Def_ChapterMaschkeFiniteGroup
open BookProof.ChapterMaschkeFiniteGroup

variable {G : Type*} [Group G] {V : Type*} [AddCommGroup V] [Module ℂ V]




theorem BookProof.ChapterMaschkeFiniteGroup.maschke_decomposition [Finite G] [FiniteDimensional ℂ V]
    (ρ : Representation ℂ G V) (W : Submodule ℂ V) (hW : IsInvariant ρ W) :
    ∃ (W' : Submodule ℂ V) (p : V →ₗ[ℂ] V),
      IsInvariant ρ W' ∧ IsCompl W W' ∧ (∀ x, p (p x) = p x) ∧
        LinearMap.range p = W ∧ LinearMap.ker p = W' ∧
        (∀ (g : G) (x : V), p (ρ g x) = ρ g (p x)) := by sorry
