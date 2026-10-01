-- Generated from ChapterQuantumGravityDensitized.lean — theorem BookProof.QuantumGravityDensitized.densTetrad_recover
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterQuantumGravityDensitized
open BookProof.QuantumGravityDensitized



open Filter Topology BookProof.FarisLavine

theorem BookProof.QuantumGravityDensitized.densTetrad_recover {E : Matrix (Fin 3) (Fin 3) ℝ} (h : 0 < E.det) :
    (Real.sqrt E.det)⁻¹ • densTetrad E = E := by sorry
