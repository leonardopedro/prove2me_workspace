-- Generated from ChapterFarisLavine.lean — solution of BookProof.FarisLavine.hasZeroDeficiencyOn_of_farisLavine
import Mathlib
import Definitions.Def_ChapterFarisLavine
import Theorems.Thm_BookProof_FarisLavine_essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn
import Theorems.Thm_BookProof_FarisLavine_essentiallySelfAdjointOn_of_farisLavine
open BookProof.FarisLavine




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}



open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat



open scoped ENNReal

set_option maxHeartbeats 1000000 in
key w Complex.I).1 hw), fun w hw => h2 w ?_⟩
    intro v
    rw [← neg_smul]
    exact (key w (-Complex.I)).1 hw v

theorem solution [CompleteSpace F]
    (D : Submodule ℂ F) (H N : D →ₗ[ℂ] D) (c : ℝ)
    (hH : SymmetricOn D (D.subtype.comp H)) (hN : SymmetricOn D (D.subtype.comp N))
    (hc : 0 ≤ c)
    (hNpos : ∀ x : D, 0 ≤ quadForm (D.subtype.comp N) x)
    (hNsurj : ∀ f : F, ∃ x : D, (N x : F) + (x : F) = f)
    (hcomm : ∀ x : D, |commF :=
  orm (D.subtype.comp H) (D.subtype.comp N) x|
        ≤ c * quadForm (D.subtype.comp N) x) :
      HasZeroDeficiencyOn D H :=
    (essentiallySelfAdjointOn_iff_hasZeroDeficiencyOn D H).1
