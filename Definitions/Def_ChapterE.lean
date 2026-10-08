import Mathlib


/-!
# Chapter E — Wave-function collapse versus Euler's formula

Formalization of the theorem-rich Chapter E of `book.tex`
(see `FORMALIZATION_ROADMAP.md` §E): the wave-function as a "multi-dimensional
Euler formula" parametrizing any probability distribution, with collapse =
"taking the real part."
-/

open scoped Matrix BigOperators
open Filter
open scoped Topology

namespace BookProof.ChapterE

/-! ## E.1 — The 2-state probability clock -/

/-- The 2-state wave function `Ψ t = (cos t, sin t)`. -/
noncomputable def Ψ (t : ℝ) : Fin 2 → ℝ := ![Real.cos t, Real.sin t]

/-- The rotation generator `J = [[0,-1],[1,0]]`. -/
def J : Matrix (Fin 2) (Fin 2) ℝ := !![0, -1; 1, 0]

/-
**E.1a (surjectivity of the Born map).** Every probability `p ∈ [0,1]` is
realized as `cos² t` for some angle `t`.
-/


/-
**E.1b (Euler rotation).** The matrix exponential of `t • J` is the rotation
matrix `[[cos t, -sin t],[sin t, cos t]]`.
-/


/-
**E.1b (rotation acts on the clock).** The rotation by `t` sends the initial
state `(1,0)` to `Ψ t`.
-/


/-
**E.1c (collapse = diagonal / real part).** The collapsed (diagonal) density
matrix of `Ψ t` is `½·I + ½cos(2t)·diag(1,-1)`.
-/


/-! ## E.2 — Probability-preserving linear maps -/

/-
**E.2b (uniform → vertex forces singularity).** A column-stochastic `2×f `book.tex`
(see `FORMALIZATION_ROADMAP.md` §E): the wave-function as a "multi-dimensional
Euler formula" parametrizing any probability distribution, with collapse =
"taking the real part."
-/

open scoped Matrix BigOperators
open Filter
open scoped Topology

namespace BookProof.ChapterE

/-! ## E.1 — The 2-state probability clock -/

/-- The 2-state wave function `Ψ t = (cos t, sin t)`. -/
noncomputable def Ψ (t : ℝ) : Fin 2 → ℝ := ![Real.cos t, Real.sin t]

/-- The rotation generator `J = [[0,-1],[1,0]]`. -/
def J : Matrix (Fin 2) (Fin 2) ℝ := !![0, -1; 1, 0]

/-
**E.1a (surjectivity of the Born map).** Every probability `p ∈ [0,1]` is
realized as `cos² t` for some angle `t`.
-/
theorem cos_sq_surjective {p : ℝ} (hp0 : 0 ≤ p) (hp1 : p ≤ 1) :
    ∃ t : ℝ, Real.cos t ^ 2 = p := by
  refine ⟨ Real.arccos ( Real.sqrt p ), ?_ ⟩
  rw [ Real.cos_arccos ] <;> nlinarith [ Real.mul_self_sqrt hp0 ]

/-
**E.1b (Euler rotation).** The matrix exponential of `t • J` is the rotation
matrix `[[cos t, -sin t],[sin t, cos t]]`.
-/
theorem exp_J (t : ℝ) :
    NormedSpace.exp (t • J) = !![Real.cos t, -Real.sin t; Real.sin t, Real.cos t] := by
  -- By definition of matrix exponential, we know that
  have h_exp : NormedSpace.exp (t • J) = ∑' n, (t ^ n / Nat.factorial n) • (J ^ n) := by
    simp only [div_eq_inv_mul];
    convert NormedSpace.exp_eq_tsum using 3;
    constructor;
    · exact fun _ 𝕂 {_} _ _ _ _ _ _ ↦ NormedSpace.exp_eq_tsum 𝕂;
    intro h; rw [ h ℝ ] ; simp [ mul_comm, smul_pow ] ;
    simp [ mul_comm, smul_smul ];
  -- We'll use the fact that $J^2 = -I$ to simplify the series.
  have h_simp : ∀ n : ℕ, J ^ (2 * n) = (-1 : ℝ) ^ n • 1 ∧ J ^ (2 * n + 1) = (-1 : ℝ) ^ n • J := by
    intro n; induction n <;> simp_all [ Nat.mul_succ, pow_succ, pow_mul ] ;
    simp_all [ show J * J = -1 from by ext i j; fin_cases i <;> fin_cases j <;> norm_num [ J ] ];
  -- Let's split the sum into two parts: one for even $n$ and one for odd $n$.
  have h_split : ∑' n, (t ^ n / Nat.factorial n) • (J ^ n) =
      (∑' n, (t ^ (2 * n) / Nat.factorial (2 * n)) • (J ^ (2 * n))) +
        (∑' n, (t ^ (2 * n + 1) / Nat.factorial (2 * n + 1)) • (J ^ (2 * n + 1))) := by
    rw [ ← tsum_even_add_odd ];
    · simp_all only [] ;
      have := Real.hasSum_cos t;
      convert this.summable.smul_const ( 1 : Matrix ( Fin 2 ) ( Fin 2 ) ℝ ) using 2 ; ring;
      rw [ smul_smul, mul_comm ];
    · simp_all only [← smul_assoc, smul_eq_mul];
      refine Summable.smul_const ?_ _
      refine Summable.of_norm ?_
      simp
      have base := Real.summable_pow_div_factorial (|t| : ℝ)
      refine Summable.comp_injective base ?_
      intro m n h
      simpa using h
  simp_all only [← smul_assoc, smul_eq_mul];
  -- Recognize that the sums are the Taylor series for $\cos t$ and $\sin t$.
  have h_cos_sin :
      (∑' n, (t ^ (2 * n) / Nat.factorial (2 * n)) * (-1) ^ n) = Real.cos t ∧
        (∑' n, (t ^ (2 * n + 1) / Nat.factorial (2 * n + 1)) * (-1) ^ n) = Real.sin t := by
    constructor
    · rw [ Real.cos_eq_tsum ]
      exact tsum_congr fun n => by ring
    · rw [ Real.sin_eq_tsum ]
      exact tsum_congr fun n => by ring
  rw [ Summable.tsum_smul_const, Summable.tsum_smul_const ] ;
  focus (norm_num [ h_cos_sin ]);
  · ext i j ; fin_cases i <;> fin_cases j <;> norm_num [ J ];
  · refine Summable.of_norm ?_
    simp
    have base := Real.summable_pow_div_factorial (|t| : ℝ)
    refine Summable.comp_injective base ?_
    intro m n h
    simpa using h
  · refine Summable.of_norm ?_
    simp
    have base := Real.summable_pow_div_factorial (|t| : ℝ)
    refine Summable.comp_injective base ?_
    intro m n h
    simpa using h

/-
**E.1b (rotation acts on the clock).** The rotation by `t` sends the initial
state `(1,0)` to `Ψ t`.
-/
theorem exp_J_mulVec (t : ℝ) : (NormedSpace.exp (t • J)) *ᵥ ![1, 0] = Ψ t := by
  convert congr_arg ( fun m : Matrix ( Fin 2 ) ( Fin 2 ) ℝ => m *ᵥ ![1, 0] ) ( exp_J t ) using 1;
  ext i; fin_cases i <;> norm_num [ Ψ ] ;

/-
**E.1c (collapse = diagonal / real part).** The collapsed (diagonal) density
matrix of `Ψ t` is `½·I + ½cos(2t)·diag(1,-1)`.
-/
theorem collapse_density (t : ℝ) :
    (!![Real.cos t ^ 2, 0; 0, Real.sin t ^ 2] : Matrix (Fin 2) (Fin 2) ℝ)
      = (1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)
        + (1 / 2 * Real.cos (2 * t)) • !![1, 0; 0, -1] := by
  ext i j ; fin_cases i <;> fin_cases j <;> norm_num [ Real.sin_sq, Real.cos_sq ] <;> ring

/-! ## E.2 — Probability-preserving linear maps -/

/-
**E.2b (uniform → vertex forces singularity).** A column-stochastic `2×2`
matrix that maps the uniform distribution `(½,½)` to the vertex `(1,0)` is
singular (`det = 0`); hence it is not an invertible symmetry.
-/
theorem stochastic_uniform_to_vertex_singular
    (M : Matrix (Fin 2) (Fin 2) ℝ)
    (hnonneg : ∀ i j, 0 ≤ M i j)
    (hcol : ∀ j, ∑ i, M i j = 1)
    (huniform : M *ᵥ ![1 / 2, 1 / 2] = ![1, 0]) :
    M.det = 0 := by
  simp_all [ funext_iff, Fin.forall_fin_two, Matrix.det_fin_two ];
  norm_num [ Matrix.mulVec ] at huniform ; nlinarith!

/-! ## E.3 — A unitary that uniformizes every basis state -/

/-
**E.3 (Hadamard, `n = 2`).** The normalized Hadamard matrix is unitary and
maps every basis state to the uniform Born distribution `|·|² = 1/2`.
-/


/-
**E.3 (general `n`).** For every `n ≥ 1` there is a unitary `n × n` matrix
that maps every computational basis state to the uniform Born distribution
`|·|² = 1/n` (the DFT / "black hole" uniformizer).
-/


/-! ## E.4 — Hyperspherical Born recursion onto the simplex -/

/-- The stick-breaking / hyperspherical Born map:
`Θ(θ)ₙ = (∏_{k<n} sin²θ_k)·cos²θ_n`. -/
noncomputable def stickBreaking {N : ℕ} (θ : Fin N → ℝ) (n : Fin N) : ℝ :=
    (∏ k ∈ Finset.Iio n, Real.sin (θ k) ^ 2) * Real.cos (θ n) ^ 2

/-
**E.4 (surjectivity onto the simplex).** Every probability distribution `P`
on `Fin N` is realized by the hyperspherical Born recursion of a real unit
vector, i.e. the stick-breaking map is surjective onto the probability simplex.
-/


end BookProof.ChapterE
