import Mathlib

/-!
# Chapter H1 — Hashimoto SIRK: φ-functions and resolvent algebra (roadmap N13, §0 S7)

This file formalizes the algebraic backbone of the Hashimoto–Nodera *Shift-invert
Rational Krylov (SIRK)* method (source `RiemannProof/Hashimoto.md`; `book.tex`
cites at lines 1147 / 2055).  It follows §0 S7 of the roadmap (the numerical
backbone of the Mehler/Hashimoto Fock formalism), and the `IsSchurFull`/`EXTERNAL`
design pattern: the genuinely deep analytic inputs (Crouzeix's inequality, the
Göckler–Grimm / Hashimoto RK error theorems) are named hypotheses with citation
docstrings in `ChapterH2.lean`, never axioms; everything here is proved outright.

## Deliverables (this file)

* **H1.1 — the φ-functions.** `phi : ℕ → ℂ → ℂ`, `phi 0 = exp`,
  `phi (k+1) z = ∫ s in 0..1, exp (s·z)·(1−s)^k / k!` (eq. 3); `phi_zero`,
  `phi_at_zero : phi k 0 = 1/k!`.
* **H1.2 — the φ-recurrence.** `phi_succ_mul : z · phi (k+1) z = phi k z − 1/k!`
  (integration by parts); corollary `phi_one : z ≠ 0 → phi 1 z = (exp z − 1)/z`.
* **H1.4 — numerical range & eigenvalue inclusion.** `numericalRange A` (the set
  of Rayleigh quotients) with `eigenvalue_mem_numericalRange` (every eigenvalue
  lies in `W(A)` — the easy half of Toeplitz–Hausdorff).
* **H1.6 — the resolvent shift identity (the clean SIRK algebra core).** The
  resolvent identity `resolvent_identity` and the SIRK shift form
  `resolvent_shift_mul : X_j · (1 + h(m−j)·X_m) = X_m` for `γ_j = N − h·j`
  (§4, between eqs. (10)–(11)) — purely algebraic, no analysis.

Everything is `sorry`-free and `axiom`-free (only `propext`, `Classical.choice`,
`Quot.sound`); **no `EXTERNAL` hypothesis**.
-/

open scoped BigOperators
open intervalIntegral

namespace BookProof.ChapterH1

noncomputable section

/-! ## H1.1 — the φ-functions and their values -/

/-- The φ-functions (Hashimoto eq. 3): `φ₀ = exp`, and for `k ≥ 0`
`φ_{k+1}(z) = ∫₀¹ e^{s z} (1−s)^k / k! ds`.  Each `φ_k` is entire (a convergent
power series). -/
noncomputable def phi : ℕ → ℂ → ℂ
  | 0, z => Complex.exp z
  | (k + 1), z => ∫ s in (0 : ℝ)..1, Complex.exp (s * z) * (1 - s) ^ k / k.factorial

/-- **H1.1**: `φ₀ = exp`. -/
theorem phi_zero : phi 0 = Complex.exp := rfl

@[simp] theorem phi_zero_apply (z : ℂ) : phi 0 z = Complex.exp z := rfl

theorem phi_succ_apply (k : ℕ) (z : ℂ) :
    phi (k + 1) z = ∫ s in (0 : ℝ)..1, Complex.exp (s * z) * (1 - s) ^ k / k.factorial := rfl

/-
**H1.1** (values at `0`): `φ_k(0) = 1/k!`.
For `k = 0` this is `exp 0 = 1`.  For `k+1`, the integrand at `z = 0` is
`(1−s)^k / k!`, whose integral over `[0,1]` is `1/((k+1)·k!) = 1/(k+1)!`.
-/
theorem phi_at_zero (k : ℕ) : phi k 0 = 1 / k.factorial := by
  induction k with
  | zero => ?_
  | succ k ih => ?_
  · norm_num [ phi_zero_apply ];
  · simp only [phi_succ_apply, mul_zero, Complex.exp_zero, one_mul, integral_div, one_div];
    norm_cast;
    erw [ intervalIntegral.integral_ofReal, intervalIntegral.integral_comp_sub_left fun x => x ^ k ]
        ;      norm_num [ Nat.factorial_succ ];
    ring

/-! ## H1.2 — the φ-recurrence -/

/-
**H1.2** (recurrence): `z · φ_{k+1}(z) = φ_k(z) − 1/k!`.
Integration by parts on the defining integral: with `u = e^{s z}` and
`dv = (1−s)^k/k! ds`, the boundary terms give `φ_k(z) − 1/k!` and the remaining
integral is `z·φ_{k+1}(z)`.
-/
theorem phi_succ_mul (k : ℕ) (z : ℂ) :
    z * phi (k + 1) z = phi k z - 1 / k.factorial := by
  by_cases h : z = 0
    <;> simp_all only [zero_mul, div_eq_inv_mul, mul_one];
  · rw [ phi_at_zero ] ; ring;
  · have h_int_parts : ∫ s in (0 : ℝ)..1,    deriv (fun s => Complex.exp (s * z) * (1 - s) ^ k) s =
      (Complex.exp (1 * z) * (1 - 1) ^ k) - (Complex.exp (0 * z) * (1 - 0) ^ k) := by
      rw [ intervalIntegral.integral_eq_sub_of_hasDerivAt ];
      rotate_right;
      focus (use fun x => Complex.exp ( x * z ) * ( 1 - x ) ^ k);
      · norm_num;
      · intro x hx
        have hdiff : DifferentiableAt ℂ (fun s => Complex.exp (s * z) * (1 - s) ^ k) (x : ℂ) := by
          refine DifferentiableAt.mul (Complex.differentiableAt_exp.comp _ ?_) <|
            DifferentiableAt.pow (differentiableAt_id.const_sub _) _
          exact differentiableAt_id.mul_const _
        have hderiv : HasDerivAt (fun s : ℂ => Complex.exp (s * z) * (1 - s) ^ k)
            (deriv (fun s : ℂ => Complex.exp (s * z) * (1 - s) ^ k) (x : ℂ)) (x : ℂ) :=
          hasDerivAt_deriv_iff.mpr hdiff
        simpa using hderiv.comp_ofReal
      · apply_rules [ Continuous.intervalIntegrable ];
        fun_prop;
    have h_int_parts : ∫ s in (0 : ℝ)..1,      deriv (fun s => Complex.exp (s * z) * (1 - s) ^ k) s
        = ∫ s in (0 : ℝ)..1,      (z * Complex.exp (s * z) * (1 - s) ^ k - k * Complex.exp (s * z) *
            (1 - s) ^ (k - 1)) := by
      refine intervalIntegral.integral_congr fun x hx => ?_;
      convert HasDerivAt.deriv ( HasDerivAt.mul ( HasDerivAt.comp (𝕜 := ℂ) x (Complex.hasDerivAt_exp (x * z))
          (by simpa using @hasDerivAt_mul_const ℂ _ x z)) ( HasDerivAt.comp (𝕜 := ℂ) x
          (((@hasDerivAt_id' ℂ _ x).const_sub 1).pow k) ) ) using 1
      · ext s; rfl
      · ring
    rcases k with ( _ | k ) <;> simp_all only [pow_zero, mul_one, differentiableAt_fun_id,
                                  differentiableAt_const,
                                  DifferentiableAt.fun_mul,
                                  deriv_cexp, deriv_fun_mul,
                                  deriv_id'', one_mul,
                                  deriv_const', mul_zero,
                                  add_zero, integral_mul_const,
                                  sub_self, zero_mul,
                                  Complex.exp_zero, sub_zero,
                                  CharP.cast_eq_zero, zero_tsub,
                                  integral_const_mul, zero_add,
                                  phi_zero_apply,
                                  Nat.factorial_zero,
                                  Nat.cast_one, inv_one,
                                  mul_eq_mul_left_iff, or_false,
                                  mul_assoc, Nat.cast_add,
                                  add_tsub_cancel_right, ne_eq,
                                  Nat.add_eq_zero_iff,
                                  one_ne_zero, and_false,
                                  not_false_eq_true, zero_pow,
                                  one_pow, zero_sub];
    · exact intervalIntegral.integral_congr fun x _ => by norm_num [ phi ] ;
    · rw [ intervalIntegral.integral_sub ] at * <;> norm_num at *;
      · simp_all [ Nat.factorial_succ, phi ];
        field_simp;
        grind;
      · exact Continuous.intervalIntegrable ( by continuity ) _ _;
      · exact Continuous.intervalIntegrable ( by continuity ) _ _

/-- **H1.2** (corollary): `φ₁(z) = (e^{z} − 1)/z` for `z ≠ 0`. -/
theorem phi_one {z : ℂ} (hz : z ≠ 0) : phi 1 z = (Complex.exp z - 1) / z := by
  have h := phi_succ_mul 0 z
  simp only [phi_zero_apply, Nat.factorial_zero, Nat.cast_one, div_one] at h
  field_simp
  linear_combination h

/-! ## H1.3 — the exponential-integrator Duhamel identity -/

/-- The **operator φ₁-function** as a vector-valued integral (Hashimoto eq. 3 at
`k = 0`, operator form): `phiOp1 M g = ∫₀¹ e^{s·M} g ds`.  This is the operator
analogue of `phi 1` (which is `∫₀¹ e^{s z} ds`). -/
noncomputable def phiOp1 {n : ℕ} (M : Matrix (Fin n) (Fin n) ℂ) (g : Fin n → ℂ) :
    Fin n → ℂ :=
  ∫ s in (0 : ℝ)..1, (NormedSpace.exp (s • M)).mulVec g

/-
**H1.3** (exponential-integrator Duhamel identity, scheme (4)): for a
(bounded) operator `A` the constant-forcing Duhamel term is the operator
φ₁-function, `∫₀^δ e^{(δ−s)·A} g ds = δ · phiOp1 (δ·A) g`.  Proof: substitute
`u = δ − s` (`integral_comp_sub_left`) on the left and `u = δ s`
(`smul_integral_comp_mul_left`) on the right; both equal `∫₀^δ e^{u·A} g du`.
-/
theorem duhamel_phiOp1 {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (g : Fin n → ℂ) (δ : ℝ) :
    (∫ s in (0 : ℝ)..δ, (NormedSpace.exp ((δ - s) • A)).mulVec g)
      = δ • phiOp1 (δ • A) g := by
  by_cases hδ : δ = 0;
  · aesop;
  · rw [ phiOp1, intervalIntegral.integral_comp_sub_left fun x => ( NormedSpace.exp ( x • A )
      ).mulVec g ] ; norm_num [ hδ ];
    convert intervalIntegral.integral_comp_div _ _ using 3 <;> ring <;> norm_num [ hδ ];
    simp [ hδ, smul_smul ]

/-! ## H1.4 — numerical range and eigenvalue inclusion -/

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- The **numerical range** `W(A)` of an operator: the set of Rayleigh quotients
`⟪v, A v⟫` over unit vectors `v`. -/
def numericalRange (A : E →ₗ[ℂ] E) : Set ℂ :=
  { c | ∃ v : E, ‖v‖ = 1 ∧ (inner (𝕜 := ℂ) v (A v)) = c }

/-
**H1.4** (eigenvalue inclusion — the easy half of Toeplitz–Hausdorff): every
eigenvalue of `A` lies in its numerical range.  If `A v = λ v` with `‖v‖ = 1`,
then `⟪v, A v⟫ = λ·⟪v, v⟫ = λ·‖v‖² = λ`.
-/
theorem eigenvalue_mem_numericalRange (A : E →ₗ[ℂ] E) (l : ℂ) (v : E)
    (hv : ‖v‖ = 1) (hAv : A v = l • v) : l ∈ numericalRange A := by
  use v;
  simp_all [ inner_self_eq_norm_sq_to_K ]

/-! ## H1.5 — the operator φ-function via the resolvent (Definition 2.4) -/

/-- The Taylor(1951)/Güttel(2010) transformed function `ψ_{k,γ}(x) := φ_k(γ − x⁻¹)`
(Hashimoto Definition 2.4).  The operator φ-function is then `φ_k(A) = ψ_{k,γ}(X)`
with `X = (γI − A)⁻¹` (evaluated by the holomorphic functional calculus). -/
noncomputable def psi (k : ℕ) (γ : ℂ) (x : ℂ) : ℂ := phi k (γ - x⁻¹)

/-
**H1.5** (scalar defining identity, Definition 2.4): at an eigenvalue `z` of
`A` the resolvent has eigenvalue `(γ − z)⁻¹`, and the transformed function
recovers `φ_k`: `ψ_{k,γ}((γ − z)⁻¹) = φ_k(z)`.  This is the spectral/
finite-rank-component identity that (via §0 S3, the holomorphic functional
calculus `f_γ((γI−A)⁻¹) = f(A)`) lifts to the operator equality `φ_k(A) =
ψ_{k,γ}(X)`.
-/
theorem psi_resolvent (k : ℕ) (γ z : ℂ) (_hz : γ - z ≠ 0) :
    psi k γ (γ - z)⁻¹ = phi k z := by
  unfold psi; aesop;

/-
**H1.5** (resolvent eigenvector, the spectral bridge): if `A v = z v` and
`γ − z` is invertible, then `v` is an eigenvector of the resolvent
`X = (γI − A)⁻¹` with eigenvalue `(γ − z)⁻¹`, i.e. `X v = (γ − z)⁻¹ • v`.
This is the per-component reduction underlying the CFC identity of H1.5.
-/
theorem resolvent_eigenvector {F : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F]
    (T : F →L[ℂ] F) (X : F →L[ℂ] F) (γ z : ℂ) (v : F)
    (hTv : T v = z • v) (hz : γ - z ≠ 0)
    (_hXr : (γ • (1 : F →L[ℂ] F) - T) * X = 1)
    (hXl : X * (γ • (1 : F →L[ℂ] F) - T) = 1) :
    X v = (γ - z)⁻¹ • v := by
  have key : X ((γ - z) • v) = v := by
    have := congr_arg ( fun f => f v ) hXl
    simpa [ sub_smul, hTv, smul_smul] using this
  convert congr_arg ( fun x => ( γ - z ) ⁻¹ • x ) key using 1;
  simp [ hz, smul_smul ]

/-! ## H1.6 — the resolvent shift identity (the clean SIRK algebra core) -/

variable {A : Type*} [Ring A] [Algebra ℂ A]

/-
**H1.6** (resolvent identity): if `X_j` and `X_m` are two-sided inverses of
the shifted operators `γ_j·1 − a` and `γ_m·1 − a`, then
`X_j − X_m = (γ_m − γ_j)·(X_j · X_m)`.  Purely algebraic: insert the two
inverses and cancel `a`.
-/
theorem resolvent_identity (a : A) (gj gm : ℂ) (Xj Xm : A)
    (_hjl : (algebraMap ℂ A gj - a) * Xj = 1) (hjr : Xj * (algebraMap ℂ A gj - a) = 1)
    (hml : (algebraMap ℂ A gm - a) * Xm = 1) (_hmr : Xm * (algebraMap ℂ A gm - a) = 1) :
    Xj - Xm = (gm - gj) • (Xj * Xm) := by
  -- Using the fact that $Xj * (γ_m - a) = 1$ and $Xm * (γ_m - a) = 1$, we can simplify the
  -- expression.
  have h_simp : Xj * (gm - gj) • 1 * Xm = Xj * (algebraMap ℂ A gm - a) * Xm - Xj * (algebraMap ℂ A
      gj - a) * Xm := by
    simp [ sub_mul, mul_sub, Algebra.smul_def ];
  convert h_simp.symm using 1 <;> simp [ mul_assoc, hjr, hml ]

/-
**H1.6** (SIRK shift form): with the SIRK shifts `γ_j = N − h·j` the resolvent
identity rearranges to `X_j · (1 + h·(m−j)·X_m) = X_m`.  This is the algebraic
core that turns the rational-Krylov recurrence into a shift-invert recurrence
(§4, between eqs. (10)–(11)); no analysis is needed.
-/
theorem resolvent_shift_mul (a : A) (N h : ℂ) (j m : ℂ)
    (Xj Xm : A)
    (_hjl : (algebraMap ℂ A (N - h * j) - a) * Xj = 1)
    (hjr : Xj * (algebraMap ℂ A (N - h * j) - a) = 1)
    (hml : (algebraMap ℂ A (N - h * m) - a) * Xm = 1)
    (_hmr : Xm * (algebraMap ℂ A (N - h * m) - a) = 1) :
    Xj * (1 + (h * (m - j)) • Xm) = Xm := by
  simp_all only [map_sub, map_mul, sub_mul, mul_sub, Algebra.smul_def, mul_add, mul_one];
  apply_fun ( · * Xm ) at hjr ; simp_all [ mul_assoc, sub_mul ];
  simp_all [ sub_eq_iff_eq_add ];
  simp_all [ mul_add ];
  grind

/-
**H1.7** (rational-Krylov representation, eq. 11 generating step): with the SIRK
shifts `γ_j = N − h·j` the resolvent `X_j` is the rational function
`X_j = (1 + h(m−j)·X_m)⁻¹ · X_m` of `X_m` (Hashimoto §4, "Since `X_j` is
represented as …").  This is the load-bearing algebraic identity from which the
rational-Krylov subspace equality `Q_m({X_j}, v) = {r(X_m) v | r ∈ R_SIRK}`
(eq. 11) follows by induction: each `X_j` raises the numerator degree by ≤ 1 and
multiplies the denominator by one more `(1 + h·i·z)` factor.  Purely algebraic,
from the H1.6 shift identity + commutativity of `X_m` with `1 + h(m−j)·X_m`.
-/
theorem resolvent_shift_repr (a : A) (N h : ℂ) (j m : ℂ) (Xj Xm : A)
    (hjl : (algebraMap ℂ A (N - h * j) - a) * Xj = 1)
    (hjr : Xj * (algebraMap ℂ A (N - h * j) - a) = 1)
    (hml : (algebraMap ℂ A (N - h * m) - a) * Xm = 1)
    (hmr : Xm * (algebraMap ℂ A (N - h * m) - a) = 1)
    [Invertible (1 + (h * (m - j)) • Xm)] :
    Xj = ⅟(1 + (h * (m - j)) • Xm) * Xm := by
  -- By definition of $u$, we know that $u * Xm = Xm * u$.
  have hu_comm : (1 + (h * (m - j)) • Xm) * Xm = Xm * (1 + (h * (m - j)) • Xm) := by
    simp [ mul_add, add_mul ];
  have hu_inv_comm : Xm * ⅟(1 + (h * (m - j)) • Xm) = ⅟(1 + (h * (m - j)) • Xm) * Xm := by
    apply_fun (fun x => x * ⅟(1 + (h * (m - j)) • Xm)) at hu_comm;
    simp_all only [map_sub, map_mul, mul_assoc, mul_invOf_self', mul_one];
    apply_fun (fun x => ⅟(1 + (h * (m - j)) • Xm) * x) at hu_comm; simp_all ;
  convert congr_arg ( fun x => x * ⅟ ( 1 + ( h * ( m - j ) ) • Xm ) ) ( resolvent_shift_mul a N h j
      m Xj Xm hjl hjr hml hmr ) using 1;
  · simp [ mul_assoc ];
  · exact hu_inv_comm.symm

end

end BookProof.ChapterH1
