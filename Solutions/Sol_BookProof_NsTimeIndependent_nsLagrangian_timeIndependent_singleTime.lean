-- Generated from ChapterNsTimeIndependentFlow.lean — solution of BookProof.NsTimeIndependent.nsLagrangian_timeIndependent_singleTime
import Mathlib
import Definitions.Def_ChapterNsTimeIndependentFlow
open BookProof.NsTimeIndependent












open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge
open BookProof.HashimotoShiftInvert BookProof.SirkSingleTime BookProof.QgTimeIndependent
open BookProof.FiniteSectionSingleTime
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.ThreeComponent BookProof.NavierStokesFlow.NSHashimoto
open BookProof.NavierStokesFlow.LagrangianEsa BookProof.NavierStokesFlow.LagrangianCanonical
open BookProof.NavierStokesFlow.LagrangianKatoRellich

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℝ) (hnu : 0 < nu) (f : Fin 3 → ℝ)
    (en : ℕ ≃ Vel) :
    ∃ (T : UnboundedSelfAdjoint (L2I Vel)) (S : ℕ → UnboundedSelfAdjoint (L2I Vel)),
      IsSelfAdjointExtension (lagrangianCore (lagCanData nu hnu f)) T.op ∧
        (∀ n, IsSelfAdjointExtension
          (((secOp (lagrangianCore (lagCanData nu hnu f)) (windowOfEquiv en n) :
              L2I Vel →ₗ[ℂ] L2I Vel)).comp (lpFiniteModes Vel).subtype) (S n).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : L2I Vel), ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : L2I Vel), prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s h : ℝ, prop T (t + h) (s + h) = prop T t s) ∧
        (∀ y : ℝ → L2I Vel, IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ n, IsShiftInvertC (S n).op (((l : ℝ) : ℂ) * Complex.I) (-((S n).resCLM l))) ∧
            ∀ u : L2I Vel,
              Tendsto (fun n => -((S n).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : L2I Vel) (t : ℝ),
          Tendsto (fun n => (S n).stoneU t v) atTop (𝓝 (T.stoneU t v)) :=
  finiteSection_singleTime (lagrangianCore (lagCanData nu hnu f))
      (lagrangianCore_symmetricOn (lagCanData nu hnu f)) (lagCan_esa nu hnu f)
      (windowOfEquiv_exhausts en)
