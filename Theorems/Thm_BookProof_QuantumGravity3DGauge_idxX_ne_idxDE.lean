-- Generated from ChapterQuantumGravity3DGauge.lean — theorem BookProof.QuantumGravity3DGauge.idxX_ne_idxDE
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterQuantumGravityDensitized
import Mathlib
import Definitions.Def_ChapterQuantumGravity3DGauge
open BookProof.QuantumGravity3DGauge



open MeasureTheory Complex MvPolynomial Filter Topology
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.HermiteGalerkin
open BookProof.HashimotoShiftInvert BookProof.QuantumGravityDensitized

noncomputable section

ective :
    Function.Injective (fun q : Fin 4 × Fin 4 × Fin 4 => idxDE q.1 q.2.1 q.2.2) := by
  rintro ⟨mu, nu, a⟩ ⟨mu', nu', a'⟩ h
  have h' := congrArg Fin.val h
  simp only [idxDE] at h'
  have hmu : mu.val = mu'.val := by omega
  have hnu : nu.val = nu'.val := by omega
  have ha : a.val = a'.val := by omega
  simp [Prod.ext_iff, Fin.ext_iff, hmu, hnu, ha]

theorem BookProof.QuantumGravity3DGauge.idxX_ne_idxDE (mu nu a : Fin 4) : idxX mu ≠ idxE nu a := by sorry
