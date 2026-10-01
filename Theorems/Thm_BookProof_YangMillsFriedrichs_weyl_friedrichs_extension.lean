-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.weyl_friedrichs_extension
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavineCore
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.FarisLavine




    ring
  have hd : (inner ℂ (H ⟨w, trivial⟩ - u) (H ⟨w, trivial⟩ - u) : ℂ) = 0 :=
    hzero ⟨H ⟨w, trivial⟩ - u, trivial⟩
  exact sub_eq_zero.mp (inner_self_eq_zero.mp hd)

theorem BookProof.YangMillsFriedrichs.weyl_friedrichs_extension {D : Submodule ℂ F} {n m : ℕ}
    {pi : Fin n → D →ₗ[ℂ] D} {Bf : Fin m → D →ₗ[ℂ] D}
    (friedrichs : ∀ (D' : Submodule ℂ F) (H' : D' →ₗ[ℂ] F), Dense (D' : Set F) →
      SymmetricOn D' H' → (∀ x : D', 0 ≤ quadForm H' x) →
      ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsPositiveSelfAdjointExtension H' A)
    (hdense : Dense (D : Set F))
    (hpi : ∀ i, SymmetricOn D := by sorry
