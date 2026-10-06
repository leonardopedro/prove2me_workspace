-- Generated from ChapterMaschkeFiniteGroup.lean — theorem BookProof.ChapterMaschkeFiniteGroup.rho_rho
import Mathlib
import Definitions.Def_ChapterMaschkeFiniteGroup
open BookProof.ChapterMaschkeFiniteGroup

variable {G : Type*} [Group G] {V : Type*} [AddCommGroup V] [Module ℂ V]




theorem BookProof.ChapterMaschkeFiniteGroup.rho_rho (ρ : Representation ℂ G V) (a b : G) (x : V) :
    ρ a (ρ b x) = ρ (a * b) x := by sorry
