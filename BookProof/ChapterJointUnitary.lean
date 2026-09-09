import Mathlib

/-!
# Chapter B §3 — Any finite joint probability distribution is parametrized by a unitary matrix

Formalization of the self-contained, finite-dimensional core of the `book.tex`
section *"3. Any conditional probability measure in a standard measure space is
parametrized by a unitary operator"* (Chapter *"Wave-function parametrization of
a probability measure"*, book line ~1392).

The book states that any joint probability density `p(x,y)` can be written as
`p(x,y) = |𝒰(y,x,0)|²` for a unitary operator `𝒰`, built "through the
Gram–Schmidt process" so that a chosen column of `𝒰` reproduces the wave-function
`Ψ` with `|Ψ|² = p`; and conversely, any bounded operator `B` with
`tr(B Bᴴ) = 1` defines a joint probability distribution `p = |B|²`.

Here we formalize the finite-dimensional matrix version, which is the concrete
content of the "Gram–Schmidt" construction (the abstract `L²` / Hilbert-basis
version is `BookProof.ChapterB.unit_vector_extends`).  Working over a finite index
type, the deliverables are:

* `exists_unitary_column` — every unit vector `v` (with `∑ᵢ ‖v i‖² = 1`) is a
  column of some unitary matrix (extend `v` to an orthonormal basis of
  `EuclideanSpace ℂ ι`; the coordinate matrix of that basis is unitary and its
  `i₀`-th column is `v`);
* `exists_unitary_of_prob` — every finite probability distribution `p` is the
  squared modulus `|·|²` of a column of a unitary matrix (apply the previous
  result to `v i = √(p i)`);
* `exists_unitary_joint` — the book's exact two-space statement: every joint
  probability distribution `p(x,y)` on a finite `X × Y` is `|U|²` on a column of
  a unitary matrix indexed by `X × Y`;
* `sqAbs_isProb_of_frobenius_one` — the converse: any matrix `B` with
  `∑_{i,j} ‖B i j‖² = 1` (i.e. `tr(Bᴴ B) = 1`) makes `(i,j) ↦ ‖B i j‖²` a
  genuine probability distribution.
-/

open scoped Matrix ComplexConjugate
open Matrix

namespace BookProof.ChapterJointUnitary

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-
**Crux (Gram–Schmidt / column of a unitary).** Every unit vector `v` over a
finite index type — meaning `∑ᵢ ‖v i‖² = 1` — is the `i₀`-th column of some
unitary matrix `U`.  This is the finite-dimensional form of the book's claim
that the wave-function `Ψ` can be completed to a unitary `𝒰` with a chosen column
equal to `Ψ`.
-/
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

omit [DecidableEq ι] in
/-- **Converse (Born rule from a normalized operator).** Any matrix `B` whose
Frobenius norm is `1` — equivalently `tr(Bᴴ B) = ∑_{i,j} ‖B i j‖² = 1` — defines
a genuine joint probability distribution `(i, j) ↦ ‖B i j‖²`: the entries are
nonnegative and sum to `1`. -/
theorem sqAbs_isProb_of_frobenius_one (B : Matrix ι ι ℂ)
    (hB : ∑ i, ∑ j, ‖B i j‖ ^ 2 = 1) :
    (∀ i j, 0 ≤ ‖B i j‖ ^ 2) ∧ ∑ i, ∑ j, ‖B i j‖ ^ 2 = 1 :=
  ⟨fun _ _ => sq_nonneg _, hB⟩

omit [DecidableEq ι] in
/-- The Frobenius-norm hypothesis of `sqAbs_isProb_of_frobenius_one` is exactly
`tr(Bᴴ B) = 1`, matching the book's `tr(B Bᴴ) = 1`. -/
theorem frobenius_eq_trace (B : Matrix ι ι ℂ) :
    (Matrix.trace (Bᴴ * B)).re = ∑ i, ∑ j, ‖B i j‖ ^ 2 := by
  convert Complex.ofReal_re ?_;
  simp only [trace, diag_apply, mul_apply, conjTranspose_apply, RCLike.star_def, Complex.sq_norm,
      Complex.normSq, MonoidWithZeroHom.coe_mk, ZeroHom.coe_mk, Complex.ofReal_sum,
          Complex.ofReal_add, Complex.ofReal_mul];
  rw [ Finset.sum_comm ] ; congr ; ext ; congr ; ext ; simp [ Complex.ext_iff ] ; ring;



/-- **Finite purification / linearization headline.** A normalized statistical
amplitude is obtained by applying a linear unitary matrix to a distinguished
basis state.  Thus its possibly nonlinear construction as an amplitude is
represented linearly after passage to the Hilbert-space model. -/
theorem finite_purification_linearization (v : ι → ℂ) (i₀ : ι)
    (hv : ∑ i, ‖v i‖ ^ 2 = 1) :
    ∃ U : Matrix ι ι ℂ, U ∈ Matrix.unitaryGroup ι ℂ ∧
      ∀ i, U i i₀ = v i := by
  exact exists_unitary_column v i₀ hv

end BookProof.ChapterJointUnitary
