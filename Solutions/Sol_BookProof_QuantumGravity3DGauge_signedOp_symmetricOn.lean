-- Generated from ChapterQuantumGravity3DGauge.lean — solution of BookProof.QuantumGravity3DGauge.signedOp_symmetricOn
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
import Theorems.Thm_BookProof_QuantumGravity3DGauge_signedOp_apply
open BookProof.QuantumGravity3DGauge




open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

set_option maxHeartbeats 1000000 in
 :=
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
  
  **Non-ADM note (book.tex ~8226–8244).**  The three-dimensional reduction of record fixes
  the globally defined time-like vector `v^μ = δ^μ_0`; it is **not** the ADM formalism
  (the constraints differ; ADM is only weakly hyperbolic).  Diffeomorphisms conserve
  `v^μ = δ^μ_0`, so the BRST ghosts of the reduction are **constant in the timepiece**,
  and the charge keeps the same functional form as the 4D one — see
  `BookProof/ChapterQuantumGravityBrstCharge.lean` and `Book/Starobinsky.lean`
  (gauge-fixing fermion `{G, i b_j A_0^j}`).  The coordinate set `ℝ⁸⁴` above is the full
  4D field content carried on the reduced phase space, **not** an ADM spatial-metric
  truncation.
  
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
    rw [signedOp_apply, signedOp_apply, inner_smul_left, inner_smul_right, in
