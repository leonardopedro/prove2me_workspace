import Mathlib
import BookProof.ChapterYangMillsAbelianFockEsa
import BookProof.ChapterYangMillsAbelianNoGap
import BookProof.ChapterQedFockGapChain
import BookProof.ChapterYangMillsGhostSector

/-!
# The abelian / QED thread, in one place

The abelian (`f_abc = 0`) gauge-fixed Yang–Mills Hamiltonian — the QED Hamiltonian of this
development — is treated in five different chapters.  This chapter is the index: every
statement below is a re-export, with its source named, so that a reader (or a downstream
chapter) can import one module and see the whole abelian thread at once.  It proves no new
mathematics.

The statements, and the results that carry them:

* one-particle essential self-adjointness on the Gauss–polynomial core —
  `ymAbelian_essentiallySelfAdjointOn_core`;
* every positive self-adjoint extension is the closure —
  `ymAbelian_positiveExtension_eq_closure`;
* the unitary flow — `ymAbelian_stone_flow`;
* `dΓ(H₁)` essentially self-adjoint on the finite-occupation core —
  `dGamma_ymAbelian_essentiallySelfAdjointOn_core`;
* the positive self-adjoint (Friedrichs) extension of `dΓ(H₁)`, and that it is the closure —
  `ymAbelianFock_friedrichs_extension`, `ymAbelianFock_positiveExtension_eq_closure`;
* the single-time package, unconditionally — `ymAbelianFock_timeIndependent_singleTime`;
* **no** one-particle form gap — `ym_abelian_no_one_particle_form_gap`;
* free-photon positivity, and no photon gap in the infrared-accumulating case —
  `photon_fock_positivity`, `photon_no_one_particle_gap`;
* the Faddeev–Popov ghost sector: symmetry, ghost-number conservation, decoupling on the
  ghost vacuum, essential self-adjointness — `BookProof.YangMillsGhost`.

## The shape of the abelian thread

Everything that can be settled about the abelian Hamiltonian *is* settled: the realization is
unique at both the one-particle and the Fock level, the Friedrichs selection problem is
empty, the dynamics is a genuine unitary group with a convergent shift-invert approximation
scheme, the ghost sector is free and decouples — and there is **no gap**: the abelian
instance of the mass-gap chain is vacuous (`qed_no_one_particle_form_gap`), and for an
infrared-accumulating photon dispersion no positive gap exists either
(`qed_photon_no_one_particle_gap`).  Both facts are proved, not assumed; the structure
constants are essential to any gap statement.

Everything is `sorry`-free and `axiom`-free.
-/

namespace BookProof.QedConsolidation

noncomputable section

open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.HermiteGalerkin
open BookProof.YangMillsHermite BookProof.YangMillsAbelianEsa BookProof.YmAbelianFock
open BookProof.YangMillsAbelianNoGap BookProof.QedFockGapChain
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.YangMillsGhost BookProof.QuadFockEsa
open BookProof.YangMillsFriedrichs BookProof.QgTimeIndependent
open BookProof.HermiteCore BookProof.FockDiagonalGapChain
open MeasureTheory

/-! ## The one-particle Hamiltonian -/

/-- **The abelian gauge-fixed Yang–Mills (QED) Hamiltonian is essentially self-adjoint** on
the Gauss–polynomial core of `L²(ℝ⁹⁹)`. -/
theorem qed_one_particle_esa :
    EssentiallySelfAdjointOn (polyGaussCore (d := 99)) (ymHamiltonian (coreRepPoly 99) 0) :=
  ymAbelian_essentiallySelfAdjointOn_core

/-- **The unitary flow of the one-particle Hamiltonian.** -/
theorem qed_one_particle_stone_flow :
    ∃ (T : UnboundedSelfAdjoint (L2d 99)) (U : ℝ → (L2d 99 →L[ℂ] L2d 99)),
      IsSelfAdjointExtension (ymHamiltonian (coreRepPoly 99) 0) T.op ∧ IsStoneFlow T U :=
  ymAbelian_stone_flow

/-! ## The Fock layer -/

/-- **The second quantization is essentially self-adjoint** on the finite-occupation core. -/
theorem qed_fock_esa (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp (ymAbelianHermCol e)) :=
  dGamma_ymAbelian_essentiallySelfAdjointOn_core e

/-- **The second quantization has a positive self-adjoint (Friedrichs) extension.** -/
theorem qed_fock_friedrichs_extension (e : ℕ ≃ (Fin 99 →₀ ℕ)) :
    ∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
      IsPositiveSelfAdjointExtension (dGammaOp (ymAbelianHermCol e)) A :=
  ymAbelianFock_friedrichs_extension e

/-- **The Fock Hamiltonian has a self-adjoint realization**, extracted from the
unconditional single-time package. -/
theorem qed_fock_exists_selfAdjoint_realization (e : ℕ ≃ (Fin 99 →₀ ℕ)) (en : ℕ ≃ Conf) :
    ∃ T : UnboundedSelfAdjoint Fock,
      IsSelfAdjointExtension (dGammaOp (ymAbelianHermCol e)) T.op := by
  obtain ⟨T, _S, hT, _⟩ := ymAbelianFock_timeIndependent_singleTime e en
  exact ⟨T, hT⟩

/-- **The propagator of the Fock Hamiltonian is time-translation invariant and solves the
Schrödinger equation uniquely**, extracted from the same package. -/
theorem qed_fock_time_translation (e : ℕ ≃ (Fin 99 →₀ ℕ)) (en : ℕ ≃ Conf) :
    ∃ T : UnboundedSelfAdjoint Fock,
      IsSelfAdjointExtension (dGammaOp (ymAbelianHermCol e)) T.op ∧
        (∀ t s u : ℝ, prop T (t + u) (s + u) = prop T t s) ∧
        (∀ y : ℝ → Fock, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) := by
  obtain ⟨T, _S, hT, _hS, _hprop, _hnorm, _hcomp, htrans, huniq, _⟩ :=
    ymAbelianFock_timeIndependent_singleTime e en
  exact ⟨T, hT, htrans, huniq⟩

/-! ## No gap -/

/-- **The abelian instance of the mass-gap chain is vacuous**: the one-particle form gap
fails for every `μ > 0`. -/
theorem qed_no_one_particle_form_gap (e : ℕ ≃ (Fin 99 →₀ ℕ)) {mu : ℝ} (hmu : 0 < mu) :
    ¬ ∀ x : finiteModeDomain (coreBasis e),
        mu * ‖(x : L2d 99)‖ ^ 2
          ≤ quadForm (ymHamiltonian (coreRepBasis e) (fun _ _ _ => (0 : ℝ))) x :=
  ym_abelian_no_one_particle_form_gap e hmu

/-- **No photon gap either**: for an infrared-accumulating momentum assignment the
one-particle form gap of the free photon fails for every `m > 0`. -/
theorem qed_photon_no_one_particle_gap {p : ℕ → ℝ} (hIR : ∀ ε : ℝ, 0 < ε → ∃ k, |p k| < ε)
    {m : ℝ} (hm : 0 < m) :
    ∃ x : finiteModeDomain hermiteBasis, (x : Lp ℂ 2 (volume : Measure ℝ)) ≠ 0 ∧
      quadForm ((finiteModeDomain hermiteBasis).subtype.comp
          (diagOnePart hermiteBasis (photonDispersion p))) x
        < m * ‖(x : Lp ℂ 2 (volume : Measure ℝ))‖ ^ 2 :=
  photon_no_one_particle_gap hIR hm

/-! ## The ghost sector -/

/-- **The QED gauge + ghost Hamiltonian is symmetric**, for every ghost dispersion. -/
theorem qed_ghost_symmetric {K : ℕ} (ω : Fin K → ℝ) :
    SymmetricOn (ghostCore K) (ymGhostHam 0 ω) :=
  ymGhostHam_symmetricOn 0 ω

/-- **The QED gauge + ghost Hamiltonian is essentially self-adjoint** on the glued
Gauss–polynomial core. -/
theorem qed_ghost_esa {K : ℕ} (ω : Fin K → ℝ) :
    EssentiallySelfAdjointOn (ghostCore K) (ymGhostHam 0 ω) :=
  ymGhostHam_essentiallySelfAdjointOn_core ω

/-- **The ghosts decouple on the ghost vacuum.** -/
theorem qed_ghost_vacuum_decouples {K : ℕ} (ω : Fin K → ℝ) (x : ghostCore K) :
    ((ymGhostHam 0 ω x : GhostSpace K) : ∀ _ : GConf K, L2d 99) ∅
      = ymHamiltonian (coreRepPoly 99) 0 ⟨(x : GhostSpace K) ∅, x.2.2 ∅⟩ :=
  ymGhostHam_vacuum_fibre 0 ω x

end

end BookProof.QedConsolidation
