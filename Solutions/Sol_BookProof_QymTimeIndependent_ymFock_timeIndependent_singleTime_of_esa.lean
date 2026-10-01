-- Generated from ChapterQymTimeIndependentFlow.lean — solution of BookProof.QymTimeIndependent.ymFock_timeIndependent_singleTime_of_esa
import Mathlib
import Definitions.Def_ChapterQymTimeIndependentFlow
import Theorems.Thm_BookProof_FiniteSectionSingleTime_finiteSection_singleTime
open BookProof.QymTimeIndependent




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime BookProof.QgTimeIndependent
open BookProof.FiniteSectionSingleTime BookProof.YangMillsFriedrichs
open BookProof.FockSecondQuantization BookProof.QgCouplingDGammaSum
open BookProof.YangMillsHermite BookProof.HermiteGalerkin BookProof.HermiteProductCore
open BookProof.NavierStokesFlow

noncomputable section

variable (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)

set_option maxHeartbeats 1000000 in
rodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) := by
  refine ⟨fun x => ymHamiltonian_quadForm (coreRepBasis e) fabc x, ?_⟩
  obtain ⟨Dom, A, hA⟩ := ym_fock_friedrichs_extension e fabc
  exact timeIndependent_of_selfAdjointExtension finiteOccupation_dense
    (isSelfAdjointExtension_of_positive hA)

theorem solution (en : ℕ ≃ Conf)
    (hesa : EssentiallySelfAdjointOn (lpFiniteModes Conf) (dGammaOp (ymFockCol e fabc))) :
    ∃ (T : UnboundedSelfAdjoint Fock) (S : ℕ → UnboundedSelfAdjoint Fock),
      IsSelfAdjointExtension (dGammaOp (ymFockCol e fabc)) T.op ∧
        (∀ n, IsSelfAdjointExtension
          (((secOp (dGammaOp (ymFockCol e fabc)) (windowOfEquiv en n) :
              Fock →ₗ[ℂ] Fock)).comp (lpFiniteModes Conf).subtype) (S n).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : Fock), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : Fock), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s u : ℝ, prop T (t + u) (s + u) = prop T t s) ∧
        (∀ y : ℝ → Fock, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ :=
  0 →
            IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
              (∀ n, IsShiftInvertC (S n).op (((l
