import Mathlib
import BookProof.ChapterYangMillsHermite
import BookProof.ChapterQuantumGravityDensitized

/-!
# The concrete 3D gauge-fixed gravity Hamiltonian on the Gauss–polynomial core of `L²(ℝ⁸⁴)`

`CONSOLIDATED_PLAN.md` §10.6.2 item 4 (and `PLAN_LEAN_SPECIALIST_QG_FLOW.md` **Part F**,
items F.1–F.5 and F.8) asks for the *concrete* field-space realization of the manuscript's
3D gauge-fixed gravity Hamiltonian: densitized, Weyl-ordered, written with genuine
multiplication and differentiation operators on a dense core of `L²(ℝ⁸⁴)` — the gravity
analogue of `BookProof/ChapterYangMillsHermite.lean`, whose polynomial-level machinery
(`mulOp`, `momOp`, `weylProd`, `CoreRep`) is reused verbatim here.

The ghost sector (`ℤ₂¹⁹`), the BRST charge and its nilpotency (F.6, F.7) are the companion
module `BookProof/ChapterQuantumGravityBrstCharge.lean`.

## The coordinates of `ℝ⁸⁴`

`84 = 4 + 16 + 64`: the four spacetime coordinates `x^μ`, the sixteen tetrad fields
`e_μ^a`, and the sixty-four independent derivative coordinates `∂_μ e_ν^a`
(`idxX`, `idxE`, `idxDE`, with the injectivity and disjointness lemmas that make them a
genuine coordinate system).

## What is proved

**F.1 — the singular density and its absorption.**  `qg3DDensity` is the manuscript's
Hamiltonian density `(1/(16 e))𝒮² − (1/(24 e))𝒫²` with its `1/e = 1/det e_i^a`
degeneracy; `qg3DDensity_singular` records that the coefficient really diverges as the
tetrad degenerates, and `qg3DDensity_densitized` that in the densitized variables
`S̃ = 𝒮/y`, `P̃ = 𝒫/y` (`y = √e`, Part A of the QG plan) the density becomes the
**constant-coefficient** expression `(1/16)S̃² − (1/24)P̃²` — the two-signed signature
`qgKappa` that the operator below carries.

**F.3, F.4 — the canonical structure.**  `qgCoord`/`qgMom` are the coordinate and momentum
operators on the core; `ccr_poly` is the full canonical commutation relation
`[x_j, π_k] = i δ_{jk}` at polynomial level (both the diagonal and, what the gravity CCR
`[e_μ^a, π^ν_b] = i δ^ν_μ δ^a_b` needs, the *vanishing* of the off-diagonal brackets), and
`qgCCR`/`qgCCR_tetrad` are its transports to the core.  `qgWeylProd` is the Weyl ordering
`½(PQ + QP)` of the non-commuting cross terms, symmetric on the core
(`qgWeylProd_symmetricOn`), and `commute_mom_mom` records that the momenta commute among
themselves, so no ordering ambiguity arises in the kinetic term.

**F.2, F.5 — the Hamiltonian.**  `signedOp` is the *two-signed* sum of squares
`½ Σ_j κ_j π_j² + ½ Σ_A V_A²` — the gravity analogue of `weylOp`, which the hyperbolic
signature `(1/16, −1/24)` of the densitized kinetic term forces: `signedOp_symmetricOn`
(symmetric for every real signature), `signedOp_quadForm` (the quadratic form is the
signed sum of squares `½ Σ κ_j ‖π_j x‖² + ½ Σ ‖V_A x‖²`) and `signedOp_quadForm_nonneg`
(positive exactly when the signature is nonnegative).  `qg3DHamiltonian` is the physical
instance with `qgKappa` and the torsion-type potential `torsionPoly`, `qg3D_symmetricOn`
and `qg3D_quadForm` its symmetry and quadratic form.

**F.8 — Friedrichs and Hashimoto, for the elliptic sector.**
`qg3DEllipticHamiltonian` is the same operator with the conformal direction removed
(`qgKappaElliptic ≥ 0`); `qg3DElliptic_friedrichs_extension` and
`qg3DElliptic_hashimoto_selects` instantiate the project's Friedrichs-extension and
shift-invert selection theorems on it.

## Honest boundary

The physical signature is **hyperbolic**: `qgKappa` is negative in the conformal direction
(`qgKappa_conformal_neg`), so `signedOp_quadForm_nonneg` does *not* apply to
`qg3DHamiltonian` and no Friedrichs extension is claimed for it — that is exactly the
two-signed residue recorded in `CONSOLIDATED_PLAN.md` §10.3 (`qgSymbol_indefinite` of
`ChapterQuantumGravityDensitized` is the symbol-level form of the same fact).  What is
claimed for the full two-signed operator is that it is a well-defined **symmetric**
operator on the dense Gauss–polynomial core with the stated quadratic form; the selection
of a self-adjoint extension is claimed only for the elliptic sector.  No mass gap, no
global existence, and no continuum `L²(ℝ⁸⁴)` essential self-adjointness statement is
claimed anywhere.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QuantumGravity3DGauge

open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

/-! ## F.1 — the singular Hamiltonian density and the densitized form -/

/-- The manuscript's 3D gravity Hamiltonian density,
`ℋ = (1/(16 e)) 𝒮² − (1/(24 e)) 𝒫²`, with the tetrad determinant `e = det e_i^a` in the
denominator: it is *not* defined where the tetrad degenerates. -/
def qg3DDensity (e s p : ℝ) : ℝ := 1 / (16 * e) * s ^ 2 - 1 / (24 * e) * p ^ 2

/-- **The singularity is real**: the coefficient of the kinetic terms diverges as the
tetrad determinant degenerates. -/
theorem qg3DDensity_singular : Tendsto (fun e : ℝ => 1 / e) (𝓝[>] (0 : ℝ)) atTop :=
  tendsto_inv_det_atTop

/-- **The densitized form of the density (F.2).**  In the densitized variables
`S̃ = 𝒮/y`, `P̃ = 𝒫/y` with `y = √e`, the `1/e`-singular density becomes the
constant-coefficient expression `(1/16) S̃² − (1/24) P̃²`: the coefficients are exactly
the two-signed signature `qgKappa` of the field-space operator below. -/
theorem qg3DDensity_densitized (e s p : ℝ) (he : 0 < e) :
    qg3DDensity e s p = 1 / 16 * (s / densY e) ^ 2 - 1 / 24 * (p / densY e) ^ 2 := by
  rw [qg3DDensity, kinetic_absorption e s he, conformal_absorption e p he]

/-! ## The coordinates of `ℝ⁸⁴` -/

/-- The coordinate index of the spacetime coordinate `x^μ`. -/
def idxX (mu : Fin 4) : Fin 84 := ⟨mu.val, by omega⟩

/-- The coordinate index of the tetrad field `e_μ^a`. -/
def idxE (mu a : Fin 4) : Fin 84 := ⟨4 + 4 * mu.val + a.val, by omega⟩

/-- The coordinate index of the independent derivative coordinate `∂_μ e_ν^a`. -/
def idxDE (mu nu a : Fin 4) : Fin 84 := ⟨20 + 16 * mu.val + 4 * nu.val + a.val, by omega⟩

theorem idxX_injective : Function.Injective idxX := by
  intro mu mu' h
  have := congrArg Fin.val h
  simp only [idxX] at this
  exact Fin.ext this

theorem idxE_injective : Function.Injective (fun q : Fin 4 × Fin 4 => idxE q.1 q.2) := by
  rintro ⟨mu, a⟩ ⟨mu', a'⟩ h
  have h' := congrArg Fin.val h
  simp only [idxE] at h'
  have hmu : mu.val = mu'.val := by omega
  have ha : a.val = a'.val := by omega
  simp [Prod.ext_iff, Fin.ext_iff, hmu, ha]

theorem idxDE_injective :
    Function.Injective (fun q : Fin 4 × Fin 4 × Fin 4 => idxDE q.1 q.2.1 q.2.2) := by
  rintro ⟨mu, nu, a⟩ ⟨mu', nu', a'⟩ h
  have h' := congrArg Fin.val h
  simp only [idxDE] at h'
  have hmu : mu.val = mu'.val := by omega
  have hnu : nu.val = nu'.val := by omega
  have ha : a.val = a'.val := by omega
  simp [Prod.ext_iff, Fin.ext_iff, hmu, hnu, ha]

theorem idxX_ne_idxE (mu nu a : Fin 4) : idxX mu ≠ idxE nu a := by
  intro h
  have := congrArg Fin.val h
  simp only [idxX, idxE] at this
  omega

theorem idxX_ne_idxDE (mu nu rho a : Fin 4) : idxX mu ≠ idxDE nu rho a := by
  intro h
  have := congrArg Fin.val h
  simp only [idxX, idxDE] at this
  omega

theorem idxE_ne_idxDE (mu a nu rho b : Fin 4) : idxE mu a ≠ idxDE nu rho b := by
  intro h
  have := congrArg Fin.val h
  simp only [idxE, idxDE] at this
  omega

/-! ## F.3 — the canonical commutation relations at polynomial level -/

variable {d : ℕ}

/-- **The canonical commutation relations** `[x_j, π_k] = i δ_{jk}` at polynomial level:
the diagonal case is the gravity CCR `[e_μ^a, π^ν_b] = i δ^ν_μ δ^a_b`, the off-diagonal
case is its vanishing. -/
theorem ccr_poly (j k : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    mulOp (X j) (momOp k p) - momOp k (mulOp (X j) p) = (if j = k then Complex.I else 0) • p := by
  by_cases h : j = k
  · subst h
    simpa using commutator_coord_mom j p
  · have hX : (pderiv k) (X j * p) = X j * pderiv k p := by
      rw [Derivation.leibniz]
      simp [MvPolynomial.pderiv_X, Ne.symm h]
    simp only [mulOp_apply, momOp_apply, hX, if_neg h, zero_smul, neg_smul, smul_eq_C_mul]
    ring

/-- Second partial derivatives commute. -/
theorem pderiv_comm_poly (j k : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    pderiv j (pderiv k p) = pderiv k (pderiv j p) := by
  classical
  induction p using MvPolynomial.induction_on with
  | C a => simp
  | add p q hp hq => simp [hp, hq]
  | mul_X p i hp =>
      simp only [pderiv_mul, MvPolynomial.pderiv_X, Pi.single_apply, map_add, hp]
      split_ifs with h1 h2 h2 <;> (simp; try ring)

/-- The **first-order derivative operators commute**: `[∂_j − x_j/2, ∂_k − x_k/2] = 0`. -/
theorem derOp_comm (j k : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    derOp j (derOp k p) = derOp k (derOp j p) := by
  classical
  have hjk : (pderiv j) (X k * p) = X k * pderiv j p + (if k = j then p else 0) := by
    rw [Derivation.leibniz]
    simp [MvPolynomial.pderiv_X, Pi.single_apply]
  have hkj : (pderiv k) (X j * p) = X j * pderiv k p + (if j = k then p else 0) := by
    rw [Derivation.leibniz]
    simp [MvPolynomial.pderiv_X, Pi.single_apply]
  have hcomm : (pderiv j) (pderiv k p) = (pderiv k) (pderiv j p) := pderiv_comm_poly j k p
  simp only [derOp_apply, map_sub, map_smul, hjk, hkj, hcomm]
  simp only [smul_eq_C_mul]
  by_cases h : j = k
  · subst h; ring
  · rw [if_neg h, if_neg (Ne.symm h)]; ring

/-- The momenta **commute among themselves**, so the kinetic term carries no ordering
ambiguity. -/
theorem commute_mom_mom (j k : Fin d) (p : MvPolynomial (Fin d) ℂ) :
    momOp j (momOp k p) = momOp k (momOp j p) := by
  simp only [momOp, LinearMap.smul_apply, map_smul, smul_smul, derOp_comm j k p]

/-- Multiplication operators commute among themselves. -/
theorem commute_mul_mul (f g : MvPolynomial (Fin d) ℂ) (p : MvPolynomial (Fin d) ℂ) :
    mulOp f (mulOp g p) = mulOp g (mulOp f p) := by
  simp only [mulOp_apply]; ring

/-! ## F.4 — the Weyl ordering -/

/-- **The Weyl ordering** `½(PQ + QP)` of two operators on the core, the ordering
prescription for the non-commuting `π e` cross terms of the gravity Hamiltonian. -/
def qgWeylProd (S T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    Module.End ℂ (MvPolynomial (Fin d) ℂ) := weylProd S T

/-- **The Weyl-ordered product of two symmetric operators is symmetric.** -/
theorem qgWeylProd_polySym {S T : Module.End ℂ (MvPolynomial (Fin d) ℂ)}
    (hS : PolySym S) (hT : PolySym T) : PolySym (qgWeylProd S T) := weylProd_polySym hS hT

/-- The Weyl-ordered product of a tetrad coordinate and a momentum — the concrete cross
term of the gravity Hamiltonian — is symmetric on the core. -/
theorem qgWeylProd_coord_mom_polySym (j k : Fin d) :
    PolySym (qgWeylProd (mulOp (X j)) (momOp k)) :=
  qgWeylProd_polySym (mulOp_polySym (realCoeff_X j)) (momOp_polySym k)

/-! ## F.2 / F.5 — the two-signed (hyperbolic) sum of squares -/

section Signed

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

/-- **The two-signed sum of squares** `½ Σ_j κ_j π_j² + ½ Σ_A V_A²` on a domain.  The
gravity analogue of `BookProof.YangMillsFriedrichs.weylOpDom`: the densitized gravity
kinetic term has the *hyperbolic* signature `(1/16, −1/24)`, so the coefficients `κ` are
arbitrary reals rather than all `1`. -/
def signedOpDom {n m : ℕ} (kappa : Fin n → ℝ) (pi : Fin n → D →ₗ[ℂ] D)
    (Bf : Fin m → D →ₗ[ℂ] D) : D →ₗ[ℂ] D :=
  ((1 / 2 : ℝ) : ℂ) •
    ((∑ i, ((kappa i : ℝ) : ℂ) • (pi i).comp (pi i)) + (∑ a, (Bf a).comp (Bf a)))

/-- The two-signed Hamiltonian viewed as an operator into the ambient space. -/
def signedOp {n m : ℕ} (kappa : Fin n → ℝ) (pi : Fin n → D →ₗ[ℂ] D)
    (Bf : Fin m → D →ₗ[ℂ] D) : D →ₗ[ℂ] F :=
  D.subtype.comp (signedOpDom kappa pi Bf)

theorem signedOp_apply {n m : ℕ} (kappa : Fin n → ℝ) (pi : Fin n → D →ₗ[ℂ] D)
    (Bf : Fin m → D →ₗ[ℂ] D) (x : D) :
    signedOp kappa pi Bf x
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ i, ((kappa i : ℝ) : ℂ) • ((pi i (pi i x) : D) : F))
            + ∑ a, ((Bf a (Bf a x) : D) : F)) := by
  simp [signedOp, signedOpDom]

/-- **The two-signed Hamiltonian is symmetric on its domain**, for every real signature. -/
theorem signedOp_symmetricOn {n m : ℕ} {kappa : Fin n → ℝ} {pi : Fin n → D →ₗ[ℂ] D}
    {Bf : Fin m → D →ₗ[ℂ] D} (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a))) :
    SymmetricOn D (signedOp kappa pi Bf) := by
  intro x y
  have hsq : ∀ (T : D →ₗ[ℂ] D), SymmetricOn D (D.subtype.comp T) →
      (inner ℂ ((T (T x) : D) : F) ((y : D) : F) : ℂ)
        = inner ℂ ((x : D) : F) ((T (T y) : D) : F) := by
    intro T hT
    have h1 := hT (T x) y
    have h2 := hT x (T y)
    simp only [LinearMap.comp_apply, Submodule.subtype_apply] at h1 h2
    rw [h1, h2]
  rw [signedOp_apply, signedOp_apply, inner_smul_left, inner_smul_right, inner_add_left,
    inner_add_right, sum_inner, sum_inner, inner_sum, inner_sum]
  have hpisum : ∀ i : Fin n,
      (inner ℂ (((kappa i : ℝ) : ℂ) • ((pi i (pi i x) : D) : F)) ((y : D) : F) : ℂ)
        = inner ℂ ((x : D) : F) (((kappa i : ℝ) : ℂ) • ((pi i (pi i y) : D) : F)) := by
    intro i
    rw [inner_smul_left, inner_smul_right, hsq (pi i) (hpi i), Complex.conj_ofReal]
  have hBsum : ∀ a : Fin m, (inner ℂ ((Bf a (Bf a x) : D) : F) ((y : D) : F) : ℂ)
      = inner ℂ ((x : D) : F) ((Bf a (Bf a y) : D) : F) := fun a => hsq (Bf a) (hB a)
  rw [Finset.sum_congr rfl fun i _ => hpisum i, Finset.sum_congr rfl fun a _ => hBsum a,
    Complex.conj_ofReal]

/-- **The quadratic form of the two-signed Hamiltonian is the signed sum of squares**:
`q(x) = ½ Σ κ_j ‖π_j x‖² + ½ Σ ‖V_A x‖²`. -/
theorem signedOp_quadForm {n m : ℕ} {kappa : Fin n → ℝ} {pi : Fin n → D →ₗ[ℂ] D}
    {Bf : Fin m → D →ₗ[ℂ] D} (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a))) (x : D) :
    quadForm (signedOp kappa pi Bf) x
      = 1 / 2 * (∑ i, kappa i * ‖((pi i x : D) : F)‖ ^ 2)
        + 1 / 2 * ∑ a, ‖((Bf a x : D) : F)‖ ^ 2 := by
  have hinner : (inner ℂ ((x : D) : F) (signedOp kappa pi Bf x) : ℂ)
      = (((1 / 2 * (∑ i, kappa i * ‖((pi i x : D) : F)‖ ^ 2)
          + 1 / 2 * ∑ a, ‖((Bf a x : D) : F)‖ ^ 2 : ℝ)) : ℂ) := by
    have hpi' : ∀ i : Fin n,
        (inner ℂ ((x : D) : F) (((kappa i : ℝ) : ℂ) • ((pi i (pi i x) : D) : F)) : ℂ)
          = ((kappa i * ‖((pi i x : D) : F)‖ ^ 2 : ℝ) : ℂ) := by
      intro i
      rw [inner_smul_right, inner_sq_eq_normSq (hpi i) x]
      push_cast
      ring
    rw [signedOp_apply, inner_smul_right, inner_add_right, inner_sum, inner_sum,
      Finset.sum_congr rfl fun i _ => hpi' i,
      Finset.sum_congr rfl fun a _ => inner_sq_eq_normSq (hB a) x]
    push_cast
    ring
  rw [quadForm, hinner, Complex.ofReal_re]

/-- **Positivity holds exactly in the elliptic sector**: when every coefficient of the
signature is nonnegative, the two-signed Hamiltonian is a positive operator — the
hypothesis of the Friedrichs extension theorem. -/
theorem signedOp_quadForm_nonneg {n m : ℕ} {kappa : Fin n → ℝ} {pi : Fin n → D →ₗ[ℂ] D}
    {Bf : Fin m → D →ₗ[ℂ] D} (hk : ∀ i, 0 ≤ kappa i)
    (hpi : ∀ i, SymmetricOn D (D.subtype.comp (pi i)))
    (hB : ∀ a, SymmetricOn D (D.subtype.comp (Bf a))) (x : D) :
    0 ≤ quadForm (signedOp kappa pi Bf) x := by
  rw [signedOp_quadForm hpi hB x]
  have h1 : 0 ≤ ∑ i, kappa i * ‖((pi i x : D) : F)‖ ^ 2 :=
    Finset.sum_nonneg fun i _ => mul_nonneg (hk i) (by positivity)
  have h2 : 0 ≤ ∑ a, ‖((Bf a x : D) : F)‖ ^ 2 := Finset.sum_nonneg fun a _ => by positivity
  linarith

/-- A real multiple of a symmetric operator is symmetric. -/
theorem smul_symmetricOn {T : D →ₗ[ℂ] D} (r : ℝ)
    (hT : SymmetricOn D (D.subtype.comp T)) :
    SymmetricOn D (D.subtype.comp (((r : ℝ) : ℂ) • T)) := by
  intro x y
  have h := hT x y
  simp only [LinearMap.comp_apply, Submodule.subtype_apply, LinearMap.smul_apply,
    Submodule.coe_smul] at h ⊢
  rw [inner_smul_left, inner_smul_right, h, Complex.conj_ofReal]

/-- In the elliptic sector the two-signed operator **is** the positive sum of squares of
the rescaled momenta `√κ_j π_j`, so the Yang–Mills-style Friedrichs machinery applies to
it verbatim. -/
theorem signedOp_eq_weylOp {n m : ℕ} {kappa : Fin n → ℝ} (hk : ∀ i, 0 ≤ kappa i)
    (pi : Fin n → D →ₗ[ℂ] D) (Bf : Fin m → D →ₗ[ℂ] D) :
    signedOp kappa pi Bf
      = weylOp (fun i => ((Real.sqrt (kappa i) : ℝ) : ℂ) • pi i) Bf := by
  ext x
  rw [signedOp_apply, weylOp_apply]
  congr 2
  refine Finset.sum_congr rfl fun i _ => ?_
  have hsq : (Real.sqrt (kappa i)) * (Real.sqrt (kappa i)) = kappa i :=
    Real.mul_self_sqrt (hk i)
  simp only [LinearMap.smul_apply, map_smul, Submodule.coe_smul, smul_smul]
  rw [← Complex.ofReal_mul, hsq]

end Signed

/-- Transport of a commutator identity from the polynomial level to the core: this is what
turns the polynomial canonical commutation relations into the operator ones. -/
theorem coreRep_commutator {D : Submodule ℂ (L2d d)} (Φ : CoreRep d D)
    (S T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) (c : ℂ)
    (h : ∀ p, S (T p) - T (S p) = c • p) (x : D) :
    Φ.op S (Φ.op T x) - Φ.op T (Φ.op S x) = c • x := by
  have e1 : Φ.op S (Φ.op T x) = Φ.equiv (S (T (Φ.equiv.symm x))) := by
    simp only [CoreRep.op_apply, LinearEquiv.symm_apply_apply]
  have e2 : Φ.op T (Φ.op S x) = Φ.equiv (T (S (Φ.equiv.symm x))) := by
    simp only [CoreRep.op_apply, LinearEquiv.symm_apply_apply]
  rw [e1, e2, ← map_sub, h, map_smul, LinearEquiv.apply_symm_apply]

/-! ## The gravity operators on the Gauss–polynomial core -/

section Gravity

variable {D : Submodule ℂ (L2d 84)}

/-- The **coordinate operators** of the gravity field space: multiplication by the
coordinate `x_j` (the tetrad fields `e_μ^a` and their derivative coordinates). -/
def qgCoord (Φ : CoreRep 84 D) (j : Fin 84) : D →ₗ[ℂ] D := Φ.op (mulOp (X j))

/-- The **momentum operators** `π_j = −i ∂/∂x_j` of the gravity field space (F.3). -/
def qgMom (Φ : CoreRep 84 D) (j : Fin 84) : D →ₗ[ℂ] D := Φ.op (momOp j)

theorem qgCoord_symmetricOn (Φ : CoreRep 84 D) (j : Fin 84) :
    SymmetricOn D (D.subtype.comp (qgCoord Φ j)) :=
  Φ.symmetricOn_op (mulOp_polySym (realCoeff_X j))

theorem qgMom_symmetricOn (Φ : CoreRep 84 D) (j : Fin 84) :
    SymmetricOn D (D.subtype.comp (qgMom Φ j)) :=
  Φ.symmetricOn_op (momOp_polySym j)

/-- **The gravity canonical commutation relations on the core** (F.3):
`[x_j, π_k] = i δ_{jk}`. -/
theorem qgCCR (Φ : CoreRep 84 D) (j k : Fin 84) (x : D) :
    qgCoord Φ j (qgMom Φ k x) - qgMom Φ k (qgCoord Φ j x)
      = (if j = k then Complex.I else 0) • x := by
  exact coreRep_commutator Φ (mulOp (X j)) (momOp k) _ (ccr_poly j k) x

/-- The CCR in the manuscript's index notation: `[e_μ^a, π^ν_b] = i δ^ν_μ δ^a_b`
(book.tex:8267). -/
theorem qgCCR_tetrad (Φ : CoreRep 84 D) (mu a nu b : Fin 4) (x : D) :
    qgCoord Φ (idxE mu a) (qgMom Φ (idxE nu b) x) - qgMom Φ (idxE nu b) (qgCoord Φ (idxE mu a) x)
      = (if mu = nu ∧ a = b then Complex.I else 0) • x := by
  rw [qgCCR]
  congr 1
  by_cases h : mu = nu ∧ a = b
  · obtain ⟨h1, h2⟩ := h
    subst h1; subst h2; simp
  · rw [if_neg h, if_neg]
    intro hEq
    exact h (by
      have := idxE_injective (a₁ := (mu, a)) (a₂ := (nu, b)) hEq
      exact ⟨congrArg Prod.fst this, congrArg Prod.snd this⟩)

/-- The Weyl-ordered coordinate–momentum cross term on the core is symmetric (F.4). -/
theorem qgWeylProd_symmetricOn (Φ : CoreRep 84 D) (j k : Fin 84) :
    SymmetricOn D (D.subtype.comp (Φ.op (qgWeylProd (mulOp (X j)) (momOp k)))) :=
  Φ.symmetricOn_op (qgWeylProd_coord_mom_polySym j k)

/-! ### The signature and the potential -/

/-- The **conformal direction** of the densitized field space: the coordinate `y = √e`.
It is the direction in which the densitized kinetic term carries the opposite sign. -/
def confIndex : Fin 84 := idxX 0

/-- **The hyperbolic signature of the densitized gravity kinetic term**: `1/16` in every
direction except the conformal one, where it is `−1/24` (F.2, from
`qg3DDensity_densitized`). -/
def qgKappa (j : Fin 84) : ℝ := if j = confIndex then -(1 / 24) else 1 / 16

theorem qgKappa_conformal_neg : qgKappa confIndex < 0 := by norm_num [qgKappa]

theorem qgKappa_spatial_pos {j : Fin 84} (hj : j ≠ confIndex) : 0 < qgKappa j := by
  simp [qgKappa, hj]

/-- **The signature is two-signed** — the field-space form of `qgSymbol_indefinite`: no
choice of ordering makes the densitized gravity kinetic term a positive sum of squares. -/
theorem qgKappa_indefinite : (∃ j, 0 < qgKappa j) ∧ ∃ j, qgKappa j < 0 :=
  ⟨⟨idxE 0 0, qgKappa_spatial_pos (by simpa [confIndex] using (idxX_ne_idxE 0 0 0).symm)⟩,
    ⟨confIndex, qgKappa_conformal_neg⟩⟩

/-- The **elliptic signature**: the same operator with the conformal direction removed —
the sector to which the Friedrichs machinery applies. -/
def qgKappaElliptic (_j : Fin 84) : ℝ := 1 / 16

theorem qgKappaElliptic_nonneg (j : Fin 84) : 0 ≤ qgKappaElliptic j := by
  norm_num [qgKappaElliptic]

/-- The **torsion-type potential** of the densitized field space: the antisymmetrized
derivative coordinate `∂_μ e_ν^a − ∂_ν e_μ^a`, a real polynomial in the `84` coordinates,
acting by multiplication.  It is the gravity analogue of the Yang–Mills magnetic field
`magPoly`, and the term whose square makes the potential a positive sum of squares. -/
def torsionPoly (mu nu a : Fin 4) : MvPolynomial (Fin 84) ℂ :=
  X (idxDE mu nu a) - X (idxDE nu mu a)

theorem realCoeff_torsionPoly (mu nu a : Fin 4) : RealCoeff (torsionPoly mu nu a) := by
  have h : starP (X (idxDE mu nu a) - X (idxDE nu mu a) : MvPolynomial (Fin 84) ℂ)
      = X (idxDE mu nu a) - X (idxDE nu mu a) := by
    rw [starP_sub, starP_X, starP_X]
  exact h

/-- The torsion is antisymmetric in its two spacetime indices. -/
theorem torsionPoly_antisymm (mu nu a : Fin 4) :
    torsionPoly mu nu a = -torsionPoly nu mu a := by
  simp [torsionPoly]

/-- The `64` potential operators `T_{μν}^a` on the core, indexed by `Fin 64`. -/
def torsionOps (Φ : CoreRep 84 D) (m : Fin 64) : D →ₗ[ℂ] D :=
  Φ.op (mulOp (torsionPoly ⟨m.val / 16, by omega⟩ ⟨m.val / 4 % 4, by omega⟩
    ⟨m.val % 4, by omega⟩))

theorem torsionOps_symmetricOn (Φ : CoreRep 84 D) (m : Fin 64) :
    SymmetricOn D (D.subtype.comp (torsionOps Φ m)) :=
  Φ.symmetricOn_op (mulOp_polySym (realCoeff_torsionPoly _ _ _))

/-! ### F.2, F.5 — the Hamiltonian, its symmetry and its quadratic form -/

/-- **The concrete 3D gauge-fixed gravity Hamiltonian on the Gauss–polynomial core of
`L²(ℝ⁸⁴)`** (F.2): the densitized, Weyl-ordered two-signed sum of squares
`H = ½ Σ_j κ_j π_j² + ½ Σ T²`, with the hyperbolic signature `qgKappa` produced by
`qg3DDensity_densitized` and the torsion-type potential `torsionPoly`. -/
def qg3DHamiltonian (Φ : CoreRep 84 D) : D →ₗ[ℂ] L2d 84 :=
  signedOp qgKappa (qgMom Φ) (torsionOps Φ)

set_option maxRecDepth 8000 in
theorem qg3D_apply (Φ : CoreRep 84 D) (x : D) :
    qg3DHamiltonian Φ x
      = ((1 / 2 : ℝ) : ℂ)
        • ((∑ j, ((qgKappa j : ℝ) : ℂ) • ((qgMom Φ j (qgMom Φ j x) : D) : L2d 84))
            + ∑ m, ((torsionOps Φ m (torsionOps Φ m x) : D) : L2d 84)) :=
  signedOp_apply qgKappa (qgMom Φ) (torsionOps Φ) x

/-- **F.5 — the gravity Hamiltonian is symmetric on the core**, for the physical
(hyperbolic) signature. -/
theorem qg3D_symmetricOn (Φ : CoreRep 84 D) : SymmetricOn D (qg3DHamiltonian Φ) :=
  signedOp_symmetricOn (qgMom_symmetricOn Φ) (torsionOps_symmetricOn Φ)

/-- **F.5 — its quadratic form is the signed sum of squares.**  Positivity fails for the
physical signature (`qgKappa_conformal_neg`): the conformal direction enters with the
opposite sign, which is exactly the hyperbolic residue of `CONSOLIDATED_PLAN.md` §10.3. -/
theorem qg3D_quadForm (Φ : CoreRep 84 D) (x : D) :
    quadForm (qg3DHamiltonian Φ) x
      = 1 / 2 * (∑ j, qgKappa j * ‖((qgMom Φ j x : D) : L2d 84)‖ ^ 2)
        + 1 / 2 * ∑ m, ‖((torsionOps Φ m x : D) : L2d 84)‖ ^ 2 :=
  signedOp_quadForm (qgMom_symmetricOn Φ) (torsionOps_symmetricOn Φ) x

/-! ### F.8 — the elliptic sector: Friedrichs extension and Hashimoto selection -/

/-- **The elliptic sector of the gravity Hamiltonian**: the same field-space operator with
the conformal direction's sign flipped to `+1/16`, i.e. the positive sum of squares to
which the Friedrichs machinery applies. -/
def qg3DEllipticHamiltonian (Φ : CoreRep 84 D) : D →ₗ[ℂ] L2d 84 :=
  signedOp qgKappaElliptic (qgMom Φ) (torsionOps Φ)

theorem qg3DElliptic_symmetricOn (Φ : CoreRep 84 D) :
    SymmetricOn D (qg3DEllipticHamiltonian Φ) :=
  signedOp_symmetricOn (qgMom_symmetricOn Φ) (torsionOps_symmetricOn Φ)

theorem qg3DElliptic_quadForm_nonneg (Φ : CoreRep 84 D) (x : D) :
    0 ≤ quadForm (qg3DEllipticHamiltonian Φ) x :=
  signedOp_quadForm_nonneg qgKappaElliptic_nonneg (qgMom_symmetricOn Φ)
    (torsionOps_symmetricOn Φ) x

/-- The elliptic sector written as a plain positive sum of squares of the rescaled momenta
`π_j/4` — the form the Yang–Mills selection theorems take as input. -/
theorem qg3DElliptic_eq_weylOp (Φ : CoreRep 84 D) :
    qg3DEllipticHamiltonian Φ
      = weylOp (fun j => ((Real.sqrt (qgKappaElliptic j) : ℝ) : ℂ) • qgMom Φ j) (torsionOps Φ) :=
  signedOp_eq_weylOp qgKappaElliptic_nonneg _ _

theorem qgMomScaled_symmetricOn (Φ : CoreRep 84 D) (j : Fin 84) :
    SymmetricOn D (D.subtype.comp
      (((Real.sqrt (qgKappaElliptic j) : ℝ) : ℂ) • qgMom Φ j)) :=
  smul_symmetricOn _ (qgMom_symmetricOn Φ j)

/-- **F.8 — the elliptic sector of the concrete field-space gravity Hamiltonian has a
positive self-adjoint (Friedrichs) extension.**  Nothing is claimed for the full
two-signed operator, and no mass gap or global existence statement is made. -/
theorem qg3DElliptic_friedrichs_extension :
    ∃ (Dom : Submodule ℂ (L2d 84)) (A : Dom →ₗ[ℂ] L2d 84),
      IsPositiveSelfAdjointExtension (qg3DEllipticHamiltonian (coreRepPoly 84)) A :=
  friedrichs_extension_exists
    ⟨polyGaussCore, qg3DEllipticHamiltonian (coreRepPoly 84),
      qg3DElliptic_symmetricOn _, qg3DElliptic_quadForm_nonneg _⟩
    polyGaussCore_dense

/-- **F.8 — the Hashimoto/SIRK shift-invert limit selects exactly that Friedrichs
extension** of the elliptic sector, on the finite-mode domain of the orthonormal basis
adapted to the Gauss–polynomial core. -/
theorem qg3DElliptic_hashimoto_selects (e : ℕ ≃ (Fin 84 →₀ ℕ)) {γ : ℝ} (hγ : 0 < γ) :
    ∃ (Dom : Submodule ℂ (L2d 84)) (A : Dom →ₗ[ℂ] L2d 84) (R : L2d 84 →L[ℂ] L2d 84),
      IsPositiveSelfAdjointExtension (qg3DEllipticHamiltonian (coreRepBasis e)) A ∧
        IsShiftInvert A γ R ∧ IsSelfAdjoint R ∧
        (∀ u : L2d 84, Filter.Tendsto (fun k : ℕ => galerkinCompression R (coreBasis e) k u)
          Filter.atTop (nhds (R u))) ∧
        (∀ (Dom' : Submodule ℂ (L2d 84)) (A' : Dom' →ₗ[ℂ] L2d 84),
          IsShiftInvert A' γ R → Dom' = Dom) := by
  rw [qg3DElliptic_eq_weylOp]
  exact weyl_hashimoto_selects_friedrichs (coreBasis e)
    (qgMomScaled_symmetricOn (coreRepBasis e)) (torsionOps_symmetricOn (coreRepBasis e)) hγ

/-- A concrete enumeration of the monomials of `ℂ[X₀,…,X₈₃]`, so that
`qg3DElliptic_hashimoto_selects` is not vacuous. -/
def qgEnum : ℕ ≃ (Fin 84 →₀ ℕ) :=
  letI : Denumerable (Fin 84 →₀ ℕ) := Denumerable.ofEncodableOfInfinite _
  (Denumerable.eqv (Fin 84 →₀ ℕ)).symm

end Gravity

end

end BookProof.QuantumGravity3DGauge
