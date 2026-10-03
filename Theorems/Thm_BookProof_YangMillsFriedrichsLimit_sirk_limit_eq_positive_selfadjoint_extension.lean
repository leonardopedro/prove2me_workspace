-- Generated from ChapterYangMillsFriedrichsLimit.lean — theorem BookProof.YangMillsFriedrichsLimit.sirk_limit_eq_positive_selfadjoint_extension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterH9
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterH5
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.ChapterH5
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsFriedrichsLimit

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.FarisLavine BookProof.YangMillsFriedrichs

theorem BookProof.YangMillsFriedrichsLimit.sirk_limit_eq_positive_selfadjoint_extension [CompleteSpace F] {D : Submodule ℂ F}
    (H : D →ₗ[ℂ] F) (hdenseD : Dense (D : Set F)) (hsym : SymmetricOn D H)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) (C : ℝ) (hbd : ∀ x : D, ‖H x‖ ≤ C * ‖(x : F)‖) (v : F) :
    ∃ A : F →L[ℂ] F,
      (∀ x : D, A (x : F) = H x) ∧
      IsPositiveSelfAdjointExtension H (topRestrict A) ∧
      (Dense ((⨆ n : ℕ, krylovSpan A.toLinearMap v n : Submodule ℂ F) : Set F) →
        (∀ u : F, Filter.Tendsto (fun n : ℕ => sirkCompression A v n u)
          Filter.atTop (nhds (A u)))
        ∧ ∀ B : F →L[ℂ] F,
            (∀ x ∈ (⨆ n : ℕ, krylovSpan A.toLinearMap v n : Submodule ℂ F), A x = B x) →
            A = B) := by
  obtain ⟨A, hagree, hext⟩ := friedrichs_of_bounded H hdenseD hsym hpos C hbd
  exact ⟨A, hagree, hext, fun hcyc =>
    ⟨fun u => sirk_compression_tendsto A v hcyc u, fun B hB => sirk_limit_unique A B v hcyc hB⟩⟩

end Sirk

/-! ## The Weyl-gauge Hamiltonian: the two parts combined -/

section Weyl

open BookProof.ChapterH5 BookProof.ChapterH9


/-- **The Weyl-gauge Yang–Mills Hamiltonian in the bounded regime has an
explicit positive self-adjoint extension**, and the Hashimoto/SIRK compre := by sorry
