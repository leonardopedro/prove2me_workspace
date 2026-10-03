-- Generated from ChapterYangMillsFriedrichsLimit.lean — theorem BookProof.YangMillsFriedrichsLimit.friedrichs_bounded_proper_domain_example
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsFriedrichsLimit

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.FarisLavine BookProof.YangMillsFriedrichs

theorem BookProof.YangMillsFriedrichsLimit.friedrichs_bounded_proper_domain_example :
    ∃ (D : Submodule ℂ (ℓ²(ℕ, ℂ))) (A : ℓ²(ℕ, ℂ) →L[ℂ] ℓ²(ℕ, ℂ)),
      Dense (D : Set (ℓ²(ℕ, ℂ))) ∧ D ≠ ⊤ ∧
      (∀ x : D, A (x : ℓ²(ℕ, ℂ)) = D.subtype x) ∧
      IsPositiveSelfAdjointExtension D.subtype (topRestrict A) := by
  set b : HilbertBasis ℕ ℂ (ℓ²(ℕ, ℂ)) := HilbertBasis.ofRepr (LinearIsometryEquiv.refl ℂ _) with hb
  set D : Submodule ℂ (ℓ²(ℕ, ℂ)) := Submodule.span ℂ (Set.range b) with hD
  have hdense : Dense (D : Set (ℓ²(ℕ, ℂ))) :=
    Submodule.dense_iff_topologicalClosure_eq_top.mpr b.dense_span
  obtain ⟨A, hagree, hext⟩ := friedrichs_bounded_nontrivial_example D hdense
  refine ⟨D, A, hdense, ?_, hagree, hex := by sorry
