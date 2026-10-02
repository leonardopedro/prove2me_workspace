-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.qgCCR_tetrad
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_idxE_injective
import Theorems.Thm_BookProof_QuantumGravity3DGauge_qgCCR
open BookProof.QuantumGravity3DGauge

variable {d : ℕ}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}
variable {D : Submodule ℂ (L2d 84)}

set_option maxHeartbeats 1000000 in
import Mathlib
import BookProof.ChapterYangMillsHermite
import BookProof.ChapterQuantumGravityDensitized

theorem solution : Tendsto (fun e : ℝ => 1 / e) (𝓝[>] (0 : ℝ)) atTop :=
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

/-- :=
  **The gravity canonical commutation relations on the core** (F.3):
  `[x_j, π_k] = i δ_{jk}`. -/
  theorem qgCCR (Φ : CoreRep 84 D) (j k : Fin 84) (x : D) :
      qgCoord Φ j (qgMom Φ k x) - qgMom Φ k (qgCoord Φ j x)
        = (if j = k then Complex.I else 0) • x := by
    exact coreRep_commutator Φ (mulOp (X j
