-- Generated from ChapterStrichartzHermiteQG.lean — solution of BookProof.HermiteStrichartzQG.hermiteCoreOp_hermiteLp
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Theorems.Thm_BookProof_HermiteStrichartzQG_hermiteLp_mem_hermiteCore
import Theorems.Thm_BookProof_HermiteStrichartzQG_hermiteRepr_symm_single
import Theorems.Thm_BookProof_QuantumGravityDensitized_mulHamiltonian_mulBasis
open BookProof.HermiteStrichartzQG




open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℕ → ℝ) (n : ℕ) :
    hermiteCoreOp lam ⟨hermiteLp n, hermiteLp_mem_hermiteCore n⟩
      = ((lam n : ℂ)) • hermiteLp n := by

  have hsub : hermiteDiagRestrict lam ⟨hermiteLp n, hermiteLp_mem_hermiteDiagDomain lam n⟩
      = mulBasis lam n := by
    apply Subtype.ext
    simp [hermiteDiagRestrict, mulBasis]
  have hsmul : (lp.single 2 n ((lam n : ℂ)) : L2Nat)
      = ((lam n : ℂ)) • (lp.single 2 n (1 : ℂ) : L2Nat) := by
    rw [← lp.single_smul]
    simp
  simp only [hermiteCoreOp, LinearMap.comp_apply, Submodule.inclusion_apply, hermiteDiagOp,
    hsub, mulHamiltonian_mulBasis, hsmul]
  simp
  all_goals first
  | exact rfl
  | trace_state
