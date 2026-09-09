import Mathlib
import BookProof.ChapterQuadraticFockEsa
import BookProof.ChapterYangMillsAbelianEsa
import BookProof.ChapterQymTimeIndependentFlow

/-!
# The second quantization of the abelian gauge-fixed Yang–Mills Hamiltonian: essential
# self-adjointness on the finite-occupation core, and the single-time package with no
# hypothesis

`BookProof.ChapterQymTimeIndependentFlow` proves the Yang–Mills single-time package
(`ymFock_timeIndependent_singleTime_of_esa`) **conditionally** on essential self-adjointness
of `dΓ(H₁)` on the finite-occupation core, and discharges that hypothesis only when the
working basis diagonalizes the one-particle Hamiltonian.  `CONSOLIDATED_PLAN.md` records the
removal of that hypothesis — "`dΓ` of an *unbounded* one-particle operator" — as the honest
remaining gap of the Yang–Mills thread.  This chapter closes it in the **abelian** case,
in the product Hermite basis.

## What is proved

* `coreRep_op_comp`, `coreRep_op_add`, `coreRep_op_smul`, `coreRep_op_sum` — transport of a
  polynomial operator to the core is an algebra map.
* `ymAbelianHermOp`, **`ymAbelianHermOp_eq`** — the one-particle abelian Yang–Mills
  Hamiltonian `H₁ = ½Σπ² + ½ΣB²` on the finite-mode domain of the product Hermite basis is
  the transport of the polynomial operator `ymAbelianPoly`; `ymHamiltonian_hermCore_eq`
  records that this *is* `ymHamiltonian (coreRepHerm e) 0`, the Hamiltonian of
  `BookProof.ChapterYangMillsHermite` at `f_{abc} = 0`.
* `ymAbelianHermCol`, `ymAbelianHermCol_eq` — its matrix in the product Hermite basis.
* **`dGamma_ymAbelian_essentiallySelfAdjointOn_core`** — the headline: `dΓ(H₁)` is
  essentially self-adjoint on the finite-occupation core.  The route is
  `ymAbelianPoly_eq_fqPoly` (the identification with a general real quadratic Hamiltonian) +
  `dGamma_hermCol_essentiallySelfAdjointOn_core`; no diagonalizing basis and no `ℓ¹`
  summability of the matrix elements is assumed.
* `ymAbelianFock_friedrichs_extension` and
  **`ymAbelianFock_positiveExtension_eq_closure`** — the positive self-adjoint extension
  exists and *is* the closure: the selection problem of Part D.4 is empty here.
* **`ymAbelianFock_timeIndependent_singleTime`** — hence the full single-time package,
  **unconditionally**: the exact generator and its finite sections have self-adjoint
  realizations, the propagator is time-translation invariant and uniquely solves the
  Schrödinger equation, the Hashimoto shift-invert operators of the finite sections converge
  at every nonzero shift, and their propagators converge to the exact one at every single
  finite time.

## Honest boundary

This is the **abelian** (`f_{abc} = 0`) Hamiltonian: for `g ≠ 0` the magnetic term is cubic
in the coordinates, so `B²` is quartic and the band calculus of
`BookProof.ChapterHermiteBandCalculus` — which is a calculus of *quadratic* symbols — does
not apply.  No mass gap and no spectral information is claimed here.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.YmAbelianFock

open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs
open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime
open BookProof.FiniteSectionSingleTime BookProof.QymTimeIndependent BookProof.QgTimeIndependent

noncomputable section

variable {d : ℕ}

/-! ## The transport of a polynomial operator is multiplicative -/

theorem coreRep_op_comp {D : Submodule ℂ (L2d d)} (Φ : CoreRep d D)
    (S T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    Φ.op (S.comp T) = (Φ.op S).comp (Φ.op T) := by
  refine LinearMap.ext fun x => ?_
  simp [CoreRep.op_apply]

theorem coreRep_op_add {D : Submodule ℂ (L2d d)} (Φ : CoreRep d D)
    (S T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    Φ.op (S + T) = Φ.op S + Φ.op T := by
  refine LinearMap.ext fun x => ?_
  simp [CoreRep.op_apply]

theorem coreRep_op_smul {D : Submodule ℂ (L2d d)} (Φ : CoreRep d D) (c : ℂ)
    (T : Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    Φ.op (c • T) = c • Φ.op T := by
  refine LinearMap.ext fun x => ?_
  simp [CoreRep.op_apply]

theorem coreRep_op_sum {D : Submodule ℂ (L2d d)} (Φ : CoreRep d D) {ι : Type*} (s : Finset ι)
    (F : ι → Module.End ℂ (MvPolynomial (Fin d) ℂ)) :
    Φ.op (∑ i ∈ s, F i) = ∑ i ∈ s, Φ.op (F i) := by
  classical
  induction s using Finset.induction_on with
  | empty => refine LinearMap.ext fun x => ?_; simp [CoreRep.op_apply]
  | insert a s ha ih => rw [Finset.sum_insert ha, coreRep_op_add, ih, Finset.sum_insert ha]

/-! ## The abelian Yang–Mills Hamiltonian on the Hermite core -/

/-- The one-particle abelian Yang–Mills Hamiltonian as an endomorphism of the finite-mode
domain of the product Hermite basis. -/
def ymAbelianHermOp (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    finiteModeDomain (hermBasisN e) →ₗ[ℂ] finiteModeDomain (hermBasisN e) :=
  weylOpDom (piOps (coreRepHerm e)) (magOps (coreRepHerm e) 0)

set_option maxHeartbeats 4000000 in
-- the `L²` coercions of the Gauss–polynomial core, and the `24` Weyl-ordered squares of the
-- Yang–Mills Hamiltonian, make the defeq checks of this identification expensive
/-- It is the transport of the polynomial-level Hamiltonian. -/
theorem ymAbelianHermOp_eq (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    ymAbelianHermOp e = (coreRepHerm e).op ymAbelianPoly := by
  have h1 : (∑ m : Fin 24, (piOps (coreRepHerm e) m).comp (piOps (coreRepHerm e) m))
      = ∑ m : Fin 24, (coreRepHerm e).op
          ((YangMillsHermite.momOp (ymMomIdx m)).comp (YangMillsHermite.momOp (ymMomIdx m))) :=
    Finset.sum_congr rfl fun m _ => by rw [coreRep_op_comp]; rfl
  have h2 : (∑ m : Fin 24, (magOps (coreRepHerm e) 0 m).comp (magOps (coreRepHerm e) 0 m))
      = ∑ m : Fin 24, (coreRepHerm e).op
          ((mulOp (magPoly 0 (decodeSpace m) (decodeColor m))).comp
            (mulOp (magPoly 0 (decodeSpace m) (decodeColor m)))) :=
    Finset.sum_congr rfl fun m _ => by rw [coreRep_op_comp]; rfl
  rw [ymAbelianHermOp, weylOpDom, ymAbelianPoly, coreRep_op_smul, coreRep_op_add,
    coreRep_op_sum, coreRep_op_sum, h1, h2]

/-- Its matrix in the product Hermite basis. -/
def ymAbelianHermCol (e : ℕ ≃ (Fin 99 →₀ ℕ)) : ℕ → (ℕ →₀ ℂ) :=
  opCol (hermBasisN e) (ymAbelianHermOp e)

theorem ymAbelianHermCol_eq (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    ymAbelianHermCol e = hermCol e ymAbelianPoly := by
  rw [ymAbelianHermCol, ymAbelianHermOp_eq, hermCol]

/-- The Yang–Mills Hamiltonian of the chapter, on the Hermite core, is this operator. -/
theorem ymHamiltonian_hermCore_eq (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    ymHamiltonian (coreRepHerm e) 0
      = (finiteModeDomain (hermBasisN e)).subtype.comp (ymAbelianHermOp e) := rfl

/-! ## Essential self-adjointness of the second quantization -/

/-- **The second quantization of the abelian gauge-fixed Yang–Mills Hamiltonian is
essentially self-adjoint on the finite-occupation core.** -/
theorem dGamma_ymAbelian_essentiallySelfAdjointOn_core (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp (ymAbelianHermCol e)) := by
  rw [ymAbelianHermCol_eq]
  refine dGamma_hermCol_essentiallySelfAdjointOn_core e ?_ ?_
  · rw [ymAbelianPoly_eq_fqPoly]
    exact polySym_fqPoly _ _ _ _ _
  · rw [ymAbelianPoly_eq_fqPoly]
    exact isBand2_fqPoly _ _ _ _ _

theorem isHermCol_ymAbelianHermCol (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    IsHermCol (ymAbelianHermCol e) :=
  isHermCol_opCol (ymHamiltonian_symmetricOn (coreRepHerm e) 0)

theorem dGammaOp_ymAbelianHermCol_symmetricOn (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    SymmetricOn (lpFiniteModes Conf) (dGammaOp (ymAbelianHermCol e)) :=
  dGammaOp_symmetricOn (isHermCol_ymAbelianHermCol e)

/-- The second-quantized abelian Yang–Mills Hamiltonian has a positive self-adjoint
(Friedrichs) extension. -/
theorem ymAbelianFock_friedrichs_extension (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    ∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
      IsPositiveSelfAdjointExtension (dGammaOp (ymAbelianHermCol e)) A :=
  secondQuantization_friedrichs (hermBasisN e) (ymAbelianHermOp e)
    (ymHamiltonian_symmetricOn (coreRepHerm e) 0)
    (ymHamiltonian_quadForm_nonneg (coreRepHerm e) 0)

/-- **The selection problem is empty**: every positive self-adjoint extension of the
second-quantized abelian Yang–Mills Hamiltonian — in particular the Friedrichs extension —
is its closure. -/
theorem ymAbelianFock_positiveExtension_eq_closure (e : ℕ ≃ (Fin 99 →₀ ℕ))
    {Dom : Submodule ℂ Fock} {A : Dom →ₗ[ℂ] Fock}
    (hA : IsPositiveSelfAdjointExtension (dGammaOp (ymAbelianHermCol e)) A) :
    Dom = clDom (dGammaOp (ymAbelianHermCol e)) ∧
      ∀ (x : Fock) (h : x ∈ Dom) (h' : x ∈ clDom (dGammaOp (ymAbelianHermCol e))),
        A ⟨x, h⟩ = clExt (dGammaOp (ymAbelianHermCol e)) finiteOccupation_dense
          (dGammaOp_ymAbelianHermCol_symmetricOn e) ⟨x, h'⟩ :=
  positiveExtension_eq_closure_of_esa finiteOccupation_dense
    (dGammaOp_ymAbelianHermCol_symmetricOn e)
    (dGamma_ymAbelian_essentiallySelfAdjointOn_core e) hA

/-- **The single-time package, unconditionally, for the abelian gauge-fixed Yang–Mills
Hamiltonian.** -/
theorem ymAbelianFock_timeIndependent_singleTime (e : ℕ ≃ (Fin 99 →₀ ℕ)) (en : ℕ ≃ Conf) :
    ∃ (T : UnboundedSelfAdjoint Fock) (S : ℕ → UnboundedSelfAdjoint Fock),
      IsSelfAdjointExtension (dGammaOp (ymAbelianHermCol e)) T.op ∧
        (∀ n, IsSelfAdjointExtension
          (((secOp (dGammaOp (ymAbelianHermCol e)) (windowOfEquiv en n) :
              Fock →ₗ[ℂ] Fock)).comp (lpFiniteModes Conf).subtype) (S n).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : Fock), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : Fock), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s u : ℝ, prop T (t + u) (s + u) = prop T t s) ∧
        (∀ y : ℝ → Fock, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : Fock, Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : Fock) (t : ℝ), Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  finiteSection_singleTime (dGammaOp (ymAbelianHermCol e))
    (dGammaOp_ymAbelianHermCol_symmetricOn e)
    (dGamma_ymAbelian_essentiallySelfAdjointOn_core e) (windowOfEquiv_exhausts en)

end

end BookProof.YmAbelianFock
