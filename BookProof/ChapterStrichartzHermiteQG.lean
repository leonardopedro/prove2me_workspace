import Mathlib
import BookProof.ChapterHermiteFunctions
import BookProof.ChapterFarisLavine
import BookProof.ChapterQuantumGravityDensitized

/-!
# The Hermite core, and a Strichartz-type theorem on it

This chapter joins the two strands of the project.

`BookProof.ChapterHermiteFunctions` builds the genuine Hermite orthonormal basis
`hermiteBasis` of `L²(ℝ)` (orthogonality, completeness via Fourier uniqueness,
and the harmonic-oscillator eigenvalue equation).  This chapter defines the
**Hermite core**

`hermiteCore = span_ℂ { ψ₀, ψ₁, ψ₂, … } ⊆ L²(ℝ)`,

the finite linear combinations of Hermite functions — i.e. the polynomials times
the Gaussian `e^{-x²/4}` — and proves that a **diagonal operator** in the Hermite
basis, with an arbitrary real symbol `lam : ℕ → ℝ`, is

* symmetric on the core (`hermiteCoreOp_symmetric`),
* has **trivial deficiency at every non-real `z`** (`hermiteCoreOp_deficiencyTrivialAt`),
  which is precisely the Strichartz "finite speed / unique continuation" input, and
* is therefore **essentially self-adjoint on the core**
  (`hermiteCoreOp_essentiallySelfAdjoint`), via the *proved* route
  `BookProof.QuantumGravityDensitized.strichartz_esa_of_finiteSpeed`.

The core is dense (`hermiteCore_dense`), so this is a genuine essential
self-adjointness statement, and the operator is genuinely unbounded whenever the
symbol is (`hermiteCoreOp_not_bounded`).

Finally the result is instantiated with the **3D gauge-fixed quantum-gravity mode
symbol**: after gauge fixing and densitization, the principal symbol of the
gravity Hamiltonian is the hyperbolic form
`qgSymbol ξ ξ_y = (1/16) Σ_{a<3} ξ_a² − (1/24) ξ_y²`
of `BookProof.ChapterQuantumGravityDensitized`, and mode by mode one gets
`qg3DModeSymbol`.  The conclusion is
`qg3D_essentiallySelfAdjoint_on_hermiteCore`: the 3D gauge-fixed quantum-gravity
mode Hamiltonian is essentially self-adjoint on the Hermite core of `L²(ℝ)`.
-/

namespace BookProof.HermiteStrichartzQG

open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

/-- `L²(ℝ)` with the Lebesgue measure. -/
abbrev L2R := Lp ℂ 2 (volume : Measure ℝ)

/-- The unitary `L²(ℝ) ≃ ℓ²(ℕ)` given by the Hermite basis. -/
noncomputable def hermiteRepr : L2R ≃ₗᵢ[ℂ] L2Nat := hermiteBasis.repr

@[simp] theorem hermiteRepr_hermiteLp (n : ℕ) :
    hermiteRepr (hermiteLp n) = lp.single 2 n (1 : ℂ) := by
  rw [hermiteRepr, ← hermiteBasis_apply, HilbertBasis.repr_self]

@[simp] theorem hermiteRepr_symm_single (n : ℕ) :
    hermiteRepr.symm (lp.single 2 n (1 : ℂ)) = hermiteLp n := by
  rw [hermiteRepr, HilbertBasis.repr_symm_single, hermiteBasis_apply]

theorem inner_hermiteLp_eq_zero_iff {w : L2R} :
    (∀ n : ℕ, (inner ℂ (hermiteLp n) w : ℂ) = 0) ↔ w = 0 := by
  constructor
  · intro h
    have hrep : hermiteRepr w = 0 := by
      ext n
      simpa [hermiteRepr, HilbertBasis.repr_apply_apply] using h n
    have := congrArg hermiteRepr.symm hrep
    simpa using this
  · rintro rfl n
    simp

/-! ## The Hermite core -/

/-- **The Hermite core**: the finite linear combinations of Hermite functions,
i.e. the polynomials times the Gaussian `e^{-x²/4}`, as a submodule of `L²(ℝ)`. -/
noncomputable def hermiteCore : Submodule ℂ L2R := Submodule.span ℂ (Set.range hermiteLp)

theorem hermiteLp_mem_hermiteCore (n : ℕ) : hermiteLp n ∈ hermiteCore :=
  Submodule.subset_span ⟨n, rfl⟩

/-- The Hermite core is dense in `L²(ℝ)`: this is the completeness of the Hermite
functions proved in `BookProof.ChapterHermiteFunctions`. -/
theorem hermiteCore_dense : Dense (hermiteCore : Set L2R) := by
  rw [Submodule.dense_iff_topologicalClosure_eq_top]
  exact top_le_iff.mp hermiteLp_span_dense

/-! ## Diagonal operators in the Hermite basis -/

/-- The maximal domain of the diagonal operator with symbol `lam`: the `L²`
functions whose Hermite coefficients stay square-summable after multiplication
by `lam`. -/
noncomputable def hermiteDiagDomain (lam : ℕ → ℝ) : Submodule ℂ L2R :=
  Submodule.comap (hermiteRepr.toLinearEquiv.toLinearMap) (mulSymbolDomain lam)

/-- The restriction of the unitary to the two domains. -/
noncomputable def hermiteDiagRestrict (lam : ℕ → ℝ) :
    hermiteDiagDomain lam →ₗ[ℂ] mulSymbolDomain lam where
  toFun f := ⟨hermiteRepr (f : L2R), f.2⟩
  map_add' f g := by ext n; simp
  map_smul' c f := by ext n; simp

/-- **The diagonal operator with real symbol `lam` in the Hermite basis**,
on its maximal domain: it multiplies the `n`-th Hermite coefficient by `lam n`. -/
noncomputable def hermiteDiagOp (lam : ℕ → ℝ) : hermiteDiagDomain lam →ₗ[ℂ] L2R :=
  hermiteRepr.symm.toLinearEquiv.toLinearMap ∘ₗ
    ((mulHamiltonian lam) ∘ₗ hermiteDiagRestrict lam)

theorem hermiteLp_mem_hermiteDiagDomain (lam : ℕ → ℝ) (n : ℕ) :
    hermiteLp n ∈ hermiteDiagDomain lam := by
  have h : (hermiteRepr.toLinearEquiv.toLinearMap (hermiteLp n) : L2Nat)
      = ((mulBasis lam n : mulSymbolDomain lam) : L2Nat) := by
    simp [mulBasis]
  rw [hermiteDiagDomain, Submodule.mem_comap, h]
  exact (mulBasis lam n).2

theorem hermiteCore_le_hermiteDiagDomain (lam : ℕ → ℝ) :
    hermiteCore ≤ hermiteDiagDomain lam := by
  rw [hermiteCore, Submodule.span_le]
  rintro _ ⟨n, rfl⟩
  exact hermiteLp_mem_hermiteDiagDomain lam n

/-- **The diagonal operator restricted to the Hermite core.** -/
noncomputable def hermiteCoreOp (lam : ℕ → ℝ) : hermiteCore →ₗ[ℂ] L2R :=
  (hermiteDiagOp lam) ∘ₗ Submodule.inclusion (hermiteCore_le_hermiteDiagDomain lam)

/-- The Hermite functions are the eigenvectors: `H ψ_n = lam n ψ_n`. -/
theorem hermiteCoreOp_hermiteLp (lam : ℕ → ℝ) (n : ℕ) :
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

/-! ## Symmetry, deficiency, essential self-adjointness -/

theorem hermiteDiagOp_symmetric (lam : ℕ → ℝ) :
    SymmetricOn (hermiteDiagDomain lam) (hermiteDiagOp lam) := by
  intro x y
  have hx : (inner ℂ (hermiteDiagOp lam x) (y : L2R) : ℂ)
      = inner ℂ ((mulHamiltonian lam (hermiteDiagRestrict lam x) : L2Nat))
          ((hermiteDiagRestrict lam y : mulSymbolDomain lam) : L2Nat) := by
    rw [← hermiteRepr.inner_map_map (hermiteDiagOp lam x) (y : L2R)]
    congr 1
    simp [hermiteDiagOp]
  have hy : (inner ℂ (x : L2R) (hermiteDiagOp lam y) : ℂ)
      = inner ℂ ((hermiteDiagRestrict lam x : mulSymbolDomain lam) : L2Nat)
          ((mulHamiltonian lam (hermiteDiagRestrict lam y) : L2Nat)) := by
    rw [← hermiteRepr.inner_map_map (x : L2R) (hermiteDiagOp lam y)]
    congr 1
    simp [hermiteDiagOp]
  rw [hx, hy]
  exact mulSymbolOp_symmetric lam lam (fun _ => le_rfl) _ _

theorem hermiteCoreOp_symmetric (lam : ℕ → ℝ) :
    SymmetricOn hermiteCore (hermiteCoreOp lam) := by
  intro x y
  exact hermiteDiagOp_symmetric lam
    (Submodule.inclusion (hermiteCore_le_hermiteDiagDomain lam) x)
    (Submodule.inclusion (hermiteCore_le_hermiteDiagDomain lam) y)

/-- **The Strichartz input, proved on the Hermite core**: the deficiency space of
the adjoint of a diagonal operator with real symbol is trivial at every non-real
`z`. -/
theorem hermiteCoreOp_deficiencyTrivialAt (lam : ℕ → ℝ) {z : ℂ} (hz : z.im ≠ 0) :
    DeficiencyTrivialAt hermiteCore (hermiteCoreOp lam) z := by
  intro w hw
  refine inner_hermiteLp_eq_zero_iff.mp fun n => ?_
  have h := hw ⟨hermiteLp n, hermiteLp_mem_hermiteCore n⟩
  rw [hermiteCoreOp_hermiteLp, inner_smul_left] at h
  have hconj : (starRingEnd ℂ) ((lam n : ℂ)) = (lam n : ℂ) := Complex.conj_ofReal _
  rw [hconj] at h
  have hne : ((lam n : ℂ)) - z ≠ 0 := by
    intro hc
    have : z = ((lam n : ℝ) : ℂ) := by linear_combination -hc
    rw [this] at hz
    simp at hz
  have hprod : (((lam n : ℂ)) - z) * (inner ℂ (hermiteLp n) w : ℂ) = 0 := by
    linear_combination h
  exact (mul_eq_zero.mp hprod).resolve_left hne

/-- **Essential self-adjointness of a diagonal operator on the Hermite core.** -/
theorem hermiteCoreOp_essentiallySelfAdjoint (lam : ℕ → ℝ) :
    EssentiallySelfAdjointOn hermiteCore (hermiteCoreOp lam) :=
  strichartz_esa_of_finiteSpeed _ fun _ hz => hermiteCoreOp_deficiencyTrivialAt lam hz

/-- The construction is not a bounded-operator triviality: for an unbounded
symbol the operator is unbounded on the core. -/
theorem hermiteCoreOp_not_bounded (lam : ℕ → ℝ) (hlam : ∀ C : ℝ, ∃ n, C < |lam n|) :
    ¬ ∃ C : ℝ, ∀ f : hermiteCore, ‖hermiteCoreOp lam f‖ ≤ C * ‖(f : L2R)‖ := by
  rintro ⟨C, hC⟩
  obtain ⟨n, hn⟩ := hlam C
  have hnorm : ‖hermiteLp n‖ = 1 := by
    simpa using orthonormal_hermiteLp.norm_eq_one n
  have h := hC ⟨hermiteLp n, hermiteLp_mem_hermiteCore n⟩
  rw [hermiteCoreOp_hermiteLp, norm_smul] at h
  simp only [hnorm, mul_one, Complex.norm_real, Real.norm_eq_abs] at h
  exact absurd h (not_le.mpr hn)

/-! ## The harmonic oscillator on the Hermite core -/

/-- The harmonic-oscillator symbol `n + 1/2`. -/
noncomputable def oscillatorSymbol (n : ℕ) : ℝ := (n : ℝ) + 1 / 2

/-- On the Hermite core, the diagonal operator with the oscillator symbol acts on
the `n`-th Hermite function exactly as the differential operator `-d²/dx² + x²/4`
does (see `BookProof.HermiteCore.hermiteFun_oscillator`), multiplying it by
`n + 1/2`. -/
theorem oscillatorOp_hermiteLp (n : ℕ) :
    hermiteCoreOp oscillatorSymbol ⟨hermiteLp n, hermiteLp_mem_hermiteCore n⟩
      = (((n : ℝ) + 1 / 2 : ℝ) : ℂ) • hermiteLp n :=
  hermiteCoreOp_hermiteLp oscillatorSymbol n

/-- The pointwise differential form of the same eigenvalue equation. -/
theorem oscillator_eigenfunction (n : ℕ) (x : ℝ) :
    -(deriv (deriv (hermiteFun n)) x) + x ^ 2 / 4 * hermiteFun n x
      = oscillatorSymbol n * hermiteFun n x :=
  hermiteFun_oscillator n x

/-- **The harmonic oscillator is essentially self-adjoint on the Hermite core.** -/
theorem oscillator_essentiallySelfAdjoint_on_hermiteCore :
    EssentiallySelfAdjointOn hermiteCore (hermiteCoreOp oscillatorSymbol) :=
  hermiteCoreOp_essentiallySelfAdjoint _

/-! ## The 3D gauge-fixed quantum-gravity Hamiltonian -/

/-- The **3D gauge-fixed quantum-gravity mode symbol**: mode by mode, the
hyperbolic principal symbol `qgSymbol` of the densitized, gauge-fixed gravity
Hamiltonian in three spatial dimensions, plus a real potential. -/
noncomputable def qg3DModeSymbol (xi : ℕ → Fin 3 → ℝ) (xiY V : ℕ → ℝ) (k : ℕ) : ℝ :=
  qgSymbol (xi k) (xiY k) + V k

/-- The 3D gauge-fixed quantum-gravity Hamiltonian on the Hermite core of
`L²(ℝ)`. -/
noncomputable def qg3DHermiteHamiltonian (xi : ℕ → Fin 3 → ℝ) (xiY V : ℕ → ℝ) :
    hermiteCore →ₗ[ℂ] L2R :=
  hermiteCoreOp (qg3DModeSymbol xi xiY V)

theorem qg3D_symmetric (xi : ℕ → Fin 3 → ℝ) (xiY V : ℕ → ℝ) :
    SymmetricOn hermiteCore (qg3DHermiteHamiltonian xi xiY V) :=
  hermiteCoreOp_symmetric _

theorem qg3D_deficiencyTrivialAt (xi : ℕ → Fin 3 → ℝ) (xiY V : ℕ → ℝ) {z : ℂ}
    (hz : z.im ≠ 0) :
    DeficiencyTrivialAt hermiteCore (qg3DHermiteHamiltonian xi xiY V) z :=
  hermiteCoreOp_deficiencyTrivialAt _ hz

/-- **Strichartz-type theorem for the 3D gauge-fixed quantum-gravity
Hamiltonian**: on the Hermite core of `L²(ℝ)` — a dense subspace — the gravity
mode Hamiltonian with the hyperbolic principal symbol
`(1/16) Σ_{a<3} ξ_a² − (1/24) ξ_y²` and an arbitrary real potential is
essentially self-adjoint. -/
theorem qg3D_essentiallySelfAdjoint_on_hermiteCore (xi : ℕ → Fin 3 → ℝ) (xiY V : ℕ → ℝ) :
    EssentiallySelfAdjointOn hermiteCore (qg3DHermiteHamiltonian xi xiY V) :=
  hermiteCoreOp_essentiallySelfAdjoint _

/-- The same for the one-mode form `qgModeSymbol` of
`BookProof.ChapterQuantumGravityDensitized`, now realized on the Hermite core of
`L²(ℝ)` rather than abstractly on `ℓ²(ℕ)`. -/
theorem qgMode_essentiallySelfAdjoint_on_hermiteCore (a b V : ℕ → ℝ) :
    EssentiallySelfAdjointOn hermiteCore (hermiteCoreOp (qgModeSymbol a b V)) :=
  hermiteCoreOp_essentiallySelfAdjoint _

/-- The hyperbolic symbol is genuinely indefinite and unbounded, so the theorem
above is not a bounded-operator statement: taking the purely spatial modes
`ξ_a(k) = k`, `ξ_y = V = 0` gives an unbounded symbol. -/
theorem qg3D_not_bounded :
    ¬ ∃ C : ℝ, ∀ f : hermiteCore,
      ‖qg3DHermiteHamiltonian (fun k _ => (k : ℝ)) 0 0 f‖ ≤ C * ‖(f : L2R)‖ := by
  refine hermiteCoreOp_not_bounded _ fun C => ?_
  obtain ⟨k, hk⟩ := exists_nat_gt (|C| * 16 / 3 + 16)
  refine ⟨k, ?_⟩
  have hval : qg3DModeSymbol (fun k _ => (k : ℝ)) 0 0 k = 3 / 16 * (k : ℝ) ^ 2 := by
    simp [qg3DModeSymbol, qgSymbol]
    ring
  have hk0 : (0 : ℝ) ≤ (k : ℝ) := Nat.cast_nonneg k
  rw [hval, abs_of_nonneg (by positivity)]
  nlinarith [abs_nonneg C, le_abs_self C]

end BookProof.HermiteStrichartzQG
