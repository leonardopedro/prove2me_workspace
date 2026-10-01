-- Generated from ChapterQymTimeIndependentFlow.lean — solution of BookProof.QymTimeIndependent.ymFock_diagonalBasis_timeIndependent_singleTime
import Mathlib
import Definitions.Def_ChapterQymTimeIndependentFlow
import Theorems.Thm_BookProof_QymTimeIndependent_ymFock_timeIndependent_singleTime_of_esa
import Theorems.Thm_BookProof_QgCouplingDGammaSum_dGammaOp_diagCol_essentiallySelfAdjoint
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
 ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : Fock, Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : Fock) (t : ℝ), Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  finiteSection_singleTime (dGammaOp (ymFockCol e fabc))
    (dGammaOp_ymFockCol_symmetricOn e fabc) hesa (windowOfEquiv_exhausts en)

theorem solution (en : ℕ ≃ Conf) (lam : ℕ → ℝ)
    (hlam : ∀ k, 0 ≤ lam k) (hdiag : ymFockCol e fabc = diagCol lam) :
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
              (∀ n, IsShiftInvertC (S n).op ((
