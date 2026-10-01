-- Generated from ChapterYangMillsFriedrichs.lean — theorem BookProof.YangMillsFriedrichs.weylOpDom_quadForm
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]



open BookProof.FarisLavine



variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

inner ℂ ((x : D) : F) ((Bf a (Bf a y) : D) : F) := fun a => hsq (Bf a) (hB a)
  rw [Finset.sum_congr rfl fun i _ => hpisum i, Finset.sum_congr rfl fun a _ => hBsum a,
    Complex.conj_ofReal]

theorem BookProof.YangMillsFriedrichs.weylOpDom_quadForm {n m : ℕ} {pi : Fin n → D →ₗ[ℂ] D} {Bf : Fin m → D →ₗ[ℂ] D}
    (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i))) := by sorry
