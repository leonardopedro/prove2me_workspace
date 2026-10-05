-- Generated from ChapterYangMillsAbelianFockEsa.lean — theorem BookProof.YmAbelianFock.ymAbelianFock_timeIndependent_singleTime
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteBandCalculus
import Definitions.Def_ChapterGradedBandSchurEsa
import Definitions.Def_ChapterQuadraticFockEsa
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterFullQuadraticEsa
import Definitions.Def_ChapterYangMillsAbelianEsa
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterSirkSingleTimeShift
import Definitions.Def_ChapterFiniteSectionSingleTime
import Definitions.Def_ChapterA4
import Definitions.Def_ChapterQgTimeIndependentFlow
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianFockEsa
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterHashimotoComplexShifts
import Definitions.Def_ChapterNavierStokesEsa
import Definitions.Def_ChapterNavierStokesIkebeKato
import Definitions.Def_ChapterStoneResolvent
import Definitions.Def_ChapterStoneUnitary
open BookProof.EsaClosure
open BookProof.FockSecondQuantization
open `BookProof.HashimotoShiftInvert`.
open BookProof.NavierStokesFlow.IkebeKato
open BookProof.YmAbelianFock

variable {d : ℕ}



open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur BookProof.QuadFockEsa
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic BookProof.YangMillsAbelianEsa
open BookProof.YangMillsFriedrichs
open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime
open BookProof.FiniteSectionSingleTime BookProof.QgTimeIndependent

noncomputable section


theorem BookProof.YmAbelianFock.ymAbelianFock_timeIndependent_singleTime (e : ℕ ≃ (Fin 99 →₀ ℕ)) (en : ℕ ≃ Conf) :
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
        ∀ (v : Fock) (t : ℝ), Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by sorry
