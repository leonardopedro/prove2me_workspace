-- Generated from ChapterBayesInference.lean — solution of BookProof.ChapterBayesInference.exists_unitary_reproduces_posterior
import Mathlib
import Definitions.Def_ChapterBayesInference
import Theorems.Thm_BookProof_ChapterBayesInference_joint_nonneg
import Theorems.Thm_BookProof_ChapterBayesInference_joint_sum_one
open BookProof.ChapterBayesInference



open scoped BigOperators
open Matrix

namespace BookProof.ChapterJointUnitary

/- Inlined from the unpublished `ChapterJointUnitary` bundle
(platform-world rule: an unpublished dep cannot be imported). -/
variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem exists_unitary_column (v : ι → ℂ) (i₀ : ι)
    (hv : ∑ i, ‖v i‖ ^ 2 = 1) :
    ∃ U : Matrix ι ι ℂ, U ∈ Matrix.unitaryGroup ι ℂ ∧ ∀ i, U i i₀ = v i := by
  obtain ⟨U, hU⟩ : ∃ U : Matrix ι ι ℂ,    U * U.conjTranspose = 1 ∧ U.conjTranspose * U = 1 ∧ ∀ i, U
      i i₀ = v i := by
    -- By the Gram-Schmidt process, there exists an orthonormal basis $\{u_i\}$ such that $u_{i_0} =
    -- v$.
    obtain ⟨u, hu⟩ : ∃ u : OrthonormalBasis ι ℂ (EuclideanSpace ℂ ι), u i₀ = (fun i => v i) := by
      have h_unit : ‖(EuclideanSpace.equiv ι ℂ).symm v‖ = 1 := by
        norm_num [ EuclideanSpace.norm_eq, hv ];
      obtain ⟨u, hu⟩ : ∃ u : OrthonormalBasis ι ℂ (EuclideanSpace ℂ ι),        u i₀ =
          (EuclideanSpace.equiv ι ℂ).symm v := by
        have := @Orthonormal.exists_orthonormalBasis_extension_of_card_eq;
        specialize @this ℂ _ ( EuclideanSpace ℂ ι ) _ _ _ ι _ ( by simp )
          ( fun _ => ( EuclideanSpace.equiv ι ℂ ).symm v ) { i₀ }
        simp_all [ Orthonormal ];
      exact ⟨ u, by aesop ⟩;
    refine ⟨ Matrix.of fun i j => u j i, ?_, ?_, ?_ ⟩;
    · ext i j; simp only [mul_apply, of_apply, conjTranspose_apply, RCLike.star_def] ;
      have := u.sum_repr ( EuclideanSpace.single i 1 ) ;        have := u.sum_repr (
          EuclideanSpace.single j 1 ) ;        simp_all only [one_apply] ;
      convert congr_arg ( fun x => inner ℂ ( EuclideanSpace.single i 1 ) x ) this using 1 ;
          focus (simp ; ring);
      · simp [ u.repr_apply_apply, inner ];
        ac_rfl;
      · simp [ EuclideanSpace.inner_single_left ];
    · ext i j; simp only [mul_apply, conjTranspose_apply, of_apply, RCLike.star_def, one_apply] ;
      have := u.orthonormal; simp_all only [orthonormal_iff_ite] ;
      convert this i j using 1;
      exact Finset.sum_congr rfl fun _ _ => mul_comm _ _;
    · aesop;
  constructor <;> tauto

/-
**Born parametrization of a finite probability distribution.** Every finite
probability distribution `p` (nonnegative, summing to `1`) is the squared modulus
of a column of a unitary matrix.
-/
theorem exists_unitary_of_prob (p : ι → ℝ) (i₀ : ι)
    (hp : ∀ i, 0 ≤ p i) (hsum : ∑ i, p i = 1) :
    ∃ U : Matrix ι ι ℂ, U ∈ Matrix.unitaryGroup ι ℂ ∧ ∀ i, ‖U i i₀‖ ^ 2 = p i := by
  obtain ⟨U, hU⟩ : ∃ U : Matrix ι ι ℂ,    U ∈ Matrix.unitaryGroup ι ℂ ∧ ∀ i, U i i₀ = Real.sqrt (p
      i) := by
    convert exists_unitary_column _ _ _ ; aesop;
  exact ⟨ U, hU.1, fun i => by simp [ hU.2 i, Real.sq_sqrt ( hp i ) ] ⟩

/-
**Joint two-space form (the book's `p(x,y) = |𝒰(y,x,0)|²`).** Every joint
probability distribution `p` on a finite product `X × Y` equals `‖U · ·‖²` along
a column of a unitary matrix indexed by `X × Y`.
-/
theorem exists_unitary_joint {X Y : Type*} [Fintype X] [DecidableEq X]
    [Fintype Y] [DecidableEq Y] (p : X → Y → ℝ)
    (hp : ∀ x y, 0 ≤ p x y) (hsum : ∑ x, ∑ y, p x y = 1)
    (xy₀ : X × Y) :
    ∃ U : Matrix (X × Y) (X × Y) ℂ, U ∈ Matrix.unitaryGroup (X × Y) ℂ ∧
      ∀ x y, ‖U (x, y) xy₀‖ ^ 2 = p x y := by
  have h_unitary : ∃ U : Matrix (X × Y) (X × Y) ℂ,    U ∈ Matrix.unitaryGroup (X × Y) ℂ ∧ ∀ xy, ‖U
      xy xy₀‖ ^ 2 = p xy.1 xy.2 := by
    apply exists_unitary_of_prob;
    · exact fun i => hp i.1 i.2;
    · erw [ Finset.sum_product ] ; aesop;
  exact ⟨ h_unitary.choose, h_unitary.choose_spec.1, fun x y => h_unitary.choose_spec.2 ( x, y ) ⟩

end BookProof.ChapterJointUnitary



variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]

variable {X Y : Type*} [Fintype X] [Fintype Y] [DecidableEq X] [DecidableEq Y]
variable {prior : X → ℝ} {L : X → Y → ℝ}

set_option maxHeartbeats 1000000 in

theorem solution
    (hprior : ∀ x, 0 ≤ prior x) (hprior_sum : ∑ x, prior x = 1)
    (hL : ∀ x y, 0 ≤ L x y) (hL_row : ∀ x, ∑ y, L x y = 1)
    (i₀ : X × Y) :
    ∃ U : Matrix (X × Y) (X × Y) ℂ, U ∈ Matrix.unitaryGroup (X × Y) ℂ ∧
      (∀ x y, ‖U (x, y) i₀‖ ^ 2 = joint prior L x y) ∧
      ∀ y, 0 < evidence prior L y → ∀ x,
        posterior prior L y x =
          ‖U (x, y) i₀‖ ^ 2 / ∑ x', ‖U (x', y) i₀‖ ^ 2 := by
  have h_unitary_joint := BookProof.ChapterJointUnitary.exists_unitary_joint (fun x y => joint prior
      L x y) (fun x y => joint_nonneg hprior hL x y) (joint_sum_one hprior_sum hL_row) i₀;
  obtain ⟨ U, hU₁, hU₂ ⟩ := h_unitary_joint; use U; aesop;
